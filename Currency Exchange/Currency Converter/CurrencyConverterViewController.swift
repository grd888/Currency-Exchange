//
//  CurrencyConverterViewController.swift
//  Currency Exchange
//
//  Created by Greg Delgado on 10/13/22.
//

import UIKit

class CurrencyConverterViewController: UIViewController {
  typealias Section = CurrencyConverterViewModel.Section

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

  lazy var currencyPickerView: UIView = {
    let view = UIView()
    let picker = UIPickerView()
    picker.translatesAutoresizingMaskIntoConstraints = false
    picker.dataSource = self
    picker.delegate = self
    view.addSubview(picker)
    let toolbar = UIToolbar()
    toolbar.translatesAutoresizingMaskIntoConstraints = false
    let button = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(done))
    toolbar.setItems([button], animated: false)
    view.addSubview(toolbar)
    NSLayoutConstraint.activate([
      toolbar.topAnchor.constraint(equalTo: view.topAnchor),
      toolbar.leadingAnchor.constraint(equalTo: view.leadingAnchor),
      toolbar.trailingAnchor.constraint(equalTo: view.trailingAnchor),
      toolbar.heightAnchor.constraint(equalToConstant: 36),
      picker.topAnchor.constraint(equalTo: view.topAnchor),
      picker.leadingAnchor.constraint(equalTo: view.leadingAnchor),
      picker.trailingAnchor.constraint(equalTo: view.trailingAnchor),
      picker.bottomAnchor.constraint(equalTo: view.bottomAnchor),
      picker.heightAnchor.constraint(equalToConstant: 180)
    ])
    return view
  }()

  private var currencyPickerViewBottomConstraint: NSLayoutConstraint?

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
    view.addSubview(currencyPickerView)
    currencyPickerView.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      currencyPickerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
      currencyPickerView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
    ])
    currencyPickerViewBottomConstraint = currencyPickerView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
    currencyPickerViewBottomConstraint?.isActive = true
  }

  func currencyCell(_ tableView: UITableView, indexPath: IndexPath) -> UITableViewCell {
    if indexPath.row == 0 {
      let cell = tableView.dequeueReusableCell(
        withIdentifier: SourceCell.reuseIdentifier,
        // swiftlint:disable:next force_cast
        for: indexPath) as! SourceCell
      cell.configure(with: viewModel.getSourceCellViewModel())
      return cell
    }
    let cell = tableView.dequeueReusableCell(
      withIdentifier: DestinationCell.reuseIdentifier,
      // swiftlint:disable:next force_cast
      for: indexPath) as! DestinationCell
    return cell
  }

  private func setPickerVisible(_ show: Bool) {
    guard let currencyPickerViewBottomConstraint = currencyPickerViewBottomConstraint else {
      return
    }
    currencyPickerViewBottomConstraint.constant = show ? 0 : currencyPickerView.frame.height
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
}

extension CurrencyConverterViewController: UIPickerViewDelegate, UIPickerViewDataSource {
  func numberOfComponents(in pickerView: UIPickerView) -> Int {
    1
  }

  func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
    3
  }

  func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
    return "Row \(component)"
  }
}
