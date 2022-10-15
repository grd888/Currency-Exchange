//
//  CurrencyConverterViewController.swift
//  Currency Exchange
//
//  Created by Greg Delgado on 10/13/22.
//

import UIKit

class CurrencyConverterViewController: UITableViewController, Storyboardable {
  typealias Section = CurrencyConverterViewModel.Section

  var viewModel = CurrencyConverterViewModel()

  override func viewDidLoad() {
    super.viewDidLoad()
    setNavigationBarBackground()
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
  }

  override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
    super.traitCollectionDidChange(previousTraitCollection)
    setNavigationBarBackground()
  }

  override func numberOfSections(in tableView: UITableView) -> Int {
    return viewModel.numberOfSections()
  }

  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return viewModel.numberOfRowsInSection(section)
  }

  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
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

  override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
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
