//
//  CurrencyConverterViewControllerTests.swift
//  Currency ExchangeTests
//
//  Created by Greg Delgado on 10/15/22.
//

@testable import Currency_Exchange
import XCTest

final class CurrencyConverterViewControllerTests: XCTestCase {
  func test_viewDidLoad_viewModelIsSet() {
    XCTAssertNotNil(makeSUT().viewModel)
  }

  func test_numberOfSections_returnsNumberOfSectionsFromViewModel() {
    let sut = makeSUT()
    let count = sut.tableView.dataSource?.numberOfSections?(in: sut.tableView)

    XCTAssertEqual(count, 3)
  }

  func test_numberOfRowsInSection0_returns1() {
    let sut = makeSUT()
    let count = sut.tableView.dataSource?.tableView(sut.tableView, numberOfRowsInSection: 0)

    XCTAssertEqual(count, 1)
  }

  func test_numberOfRowsInSection1_returns2() {
    let sut = makeSUT()
    let count = sut.tableView.dataSource?.tableView(sut.tableView, numberOfRowsInSection: 1)

    XCTAssertEqual(count, 2)
  }

  func test_numberOfRowsInSection2_returns1() {
    let sut = makeSUT()
    let count = sut.tableView.dataSource?.tableView(sut.tableView, numberOfRowsInSection: 2)

    XCTAssertEqual(count, 1)
  }

  func test_sectionHeaderTitleForSection0_returnsMyBalances() {
    let sut = makeSUT()
    let text = makeSUT().tableView.dataSource?.tableView?(sut.tableView, titleForHeaderInSection: 0)

    XCTAssertEqual(text, "MY BALANCES")
  }

  func test_sectionHeaderTitleForSection1_returnsMyBalances() {
    let sut = makeSUT()
    let text = makeSUT().tableView.dataSource?.tableView?(sut.tableView, titleForHeaderInSection: 1)

    XCTAssertEqual(text, "CURRENCY EXCHANGE")
  }

  func test_sectionHeaderTitleForSection2_returnsNil() {
    let sut = makeSUT()
    let text = makeSUT().tableView.dataSource?.tableView?(sut.tableView, titleForHeaderInSection: 2)

    XCTAssertNil(text)
  }

  // MARK: Helpers
  private func makeSUT() -> CurrencyConverterViewController {
    let viewModel = CurrencyConverterViewModel()
    let viewController = CurrencyConverterViewController.instantiate()
    viewController.viewModel = viewModel
    viewController.loadViewIfNeeded()

    return viewController
  }
}
