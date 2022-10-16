//
//  CurrencyConverterViewController.swift
//  Currency Exchange
//
//  Created by Greg Delgado on 10/13/22.
//

import UIKit

class CurrencyConverterViewController: UIViewController {
  typealias Section = CurrencyConverterViewModel.Section

  enum CurrencySelectionType {
    case source
    case destination
  }

  lazy var tableView: UITableView = {
    let tableView = UITableView(frame: .zero, style: .plain)
    tableView.separatorStyle = .none
    tableView.register(BalancesCell.self, forCellReuseIdentifier: BalancesCell.reuseIdentifier)
    tableView.register(
      UINib(nibName: SourceCell.reuseIdentifier, bundle: nil),
      forCellReuseIdentifier: SourceCell.reuseIdentifier)
    tableView.register(
      UINib(nibName: DestinationCell.reuseIdentifier, bundle: nil),
      forCellReuseIdentifier: DestinationCell.reuseIdentifier)
    tableView.register(
      UINib(nibName: ButtonCell.reuseIdentifier, bundle: nil),
      forCellReuseIdentifier: ButtonCell.reuseIdentifier)
    tableView.dataSource = self
    return tableView
  }()

  lazy var pickerContainerView: UIView = {
    let view = UIView()
    view.addSubview(pickerView)
    NSLayoutConstraint.activate([
      pickerView.topAnchor.constraint(equalTo: view.topAnchor),
      pickerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
      pickerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
      pickerView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
    ])
    view.addSubview(toolbar)
    return view
  }()

  lazy var pickerView: UIPickerView = {
    let picker = UIPickerView()
    picker.translatesAutoresizingMaskIntoConstraints = false
    picker.dataSource = self
    picker.delegate = self
    return picker
  }()

  lazy var toolbar: UIToolbar = {
    let toolbar = UIToolbar(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 35))
    toolbar.sizeToFit()
    let spacer = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
    let button = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(done))
    toolbar.setItems([spacer, button], animated: false)
    return toolbar
  }()

  private var currencyPickerViewBottomConstraint: NSLayoutConstraint?
  private var currencySelectionType = CurrencySelectionType.source

  var viewModel: CurrencyConverterViewModel

  init(viewModel: CurrencyConverterViewModel) {
    self.viewModel = viewModel
    super.init(nibName: nil, bundle: nil)
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  override func viewDidLoad() {
    super.viewDidLoad()
    title = "Currency Converter"
    setNavigationBarBackground()
    setupTableView()
    setupPickerView()
  }

  override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
    super.traitCollectionDidChange(previousTraitCollection)
    setNavigationBarBackground()
  }

  private func setupTableView() {
    view.addSubview(tableView)
    tableView.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
      tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
      tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
      tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
    ])
  }

  private func setupPickerView() {
    view.addSubview(pickerContainerView)
    pickerContainerView.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      pickerContainerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
      pickerContainerView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
    ])
    currencyPickerViewBottomConstraint =
      pickerContainerView.bottomAnchor.constraint(
        equalTo: view.bottomAnchor,
        constant: 216
      )
    currencyPickerViewBottomConstraint?.isActive = true
  }

  private func setPickerVisible(_ show: Bool) {
    guard let currencyPickerViewBottomConstraint = currencyPickerViewBottomConstraint else {
      return
    }
    currencyPickerViewBottomConstraint.constant = show ? 0 : pickerContainerView.frame.height
    UIView.animate(withDuration: 0.3, delay: 0, options: [.curveEaseInOut]) {
      self.view.layoutIfNeeded()
    }
  }

  @objc func done() {
    setPickerVisible(false)
  }
}

extension CurrencyConverterViewController: UITableViewDataSource {
  func numberOfSections(in tableView: UITableView) -> Int {
    return viewModel.numberOfSections()
  }

  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return viewModel.numberOfRowsInSection(section)
  }

  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    guard let section = Section(rawValue: indexPath.section) else {
      fatalError("Incorrect number of sections")
    }
    switch section {
    case .balances:
      let cell = tableView.dequeueReusableCell(
        withIdentifier: BalancesCell.reuseIdentifier,
        // swiftlint:disable:next force_cast
        for: indexPath) as! BalancesCell
      cell.configure(with: viewModel.getBalancesViewModel())
      return cell
    case .converter:
      return currencyCell(tableView, indexPath: indexPath)
    case .submit:
      let cell = tableView.dequeueReusableCell(withIdentifier: ButtonCell.reuseIdentifier, for: indexPath)
      return cell
    }
  }

  func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
    switch section {
    case 0:
      return "MY BALANCES"
    case 1:
      return "CURRENCY EXCHANGE"
    default:
      return nil
    }
  }

  private func currencyCell(_ tableView: UITableView, indexPath: IndexPath) -> UITableViewCell {
    if indexPath.row == 0 {
      let cell = tableView.dequeueReusableCell(
        withIdentifier: SourceCell.reuseIdentifier,
        // swiftlint:disable:next force_cast
        for: indexPath) as! SourceCell
      cell.configure(with: viewModel.getSourceCellViewModel())
      cell.delegate = self
      return cell
    }
    let cell = tableView.dequeueReusableCell(
      withIdentifier: DestinationCell.reuseIdentifier,
      // swiftlint:disable:next force_cast
      for: indexPath) as! DestinationCell
    cell.configure(with: viewModel.getDestinationCellViewModel())
    cell.delegate = self
    return cell
  }
}

extension CurrencyConverterViewController: UIPickerViewDelegate, UIPickerViewDataSource {
  func numberOfComponents(in pickerView: UIPickerView) -> Int {
    return 1
  }

  func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
    return viewModel.numberOfCurrencies()
  }

  func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
    return viewModel.currencyName(forIndex: row)
  }

  func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
    switch currencySelectionType {
    case .source:
      viewModel.selectSourceCurrency(atIndex: row)
    case .destination:
      viewModel.selectDestinationCurrency(atIndex: row)
    }
  }
}

extension CurrencyConverterViewController: SourceCellDelegate {
  func didTapCurrencyChange(_ cell: SourceCell) {
    currencySelectionType = .source
    let currentCurrencyIndex = viewModel.currentSourceCurrencyIndex()
    pickerView.selectRow(currentCurrencyIndex, inComponent: 0, animated: false)
    setPickerVisible(true)
  }
}

extension CurrencyConverterViewController: DestinationCellDelegate {
  func didTapCurrencyChange(_ cell: DestinationCell) {
    currencySelectionType = .destination
    let currentCurrencyIndex = viewModel.currentSourceCurrencyIndex()
    pickerView.selectRow(currentCurrencyIndex, inComponent: 0, animated: false)
    setPickerVisible(true)
  }
}
