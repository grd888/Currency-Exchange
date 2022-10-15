//
//  CurrencyConverterViewModelTests.swift
//  Currency ExchangeTests
//
//  Created by Greg Delgado on 10/15/22.
//

@testable import Currency_Exchange
import XCTest

final class CurrencyConverterViewModelTests: XCTestCase {
  typealias Section = CurrencyConverterViewModel.Section

  func test_numberOfSections() {
    XCTAssertEqual(makeSUT().numberOfSections(), 3)
  }
  func test_numberOfRowsInBalancesSection_returns1() {
    let section = Section.balances.rawValue
    XCTAssertEqual(makeSUT().numberOfRowsInSection(section), 1)
  }
  func test_numberOfRowsInConverterSection_returns2() {
    let section = Section.converter.rawValue
    XCTAssertEqual(makeSUT().numberOfRowsInSection(section), 2)
  }
  func test_numberOfRowsInSubmitSection_returns1() {
    let section = Section.submit.rawValue
    XCTAssertEqual(makeSUT().numberOfRowsInSection(section), 1)
  }
  func test_numberOfRowsForUnknownSection_returns0() {
    XCTAssertEqual(makeSUT().numberOfRowsInSection(999), 0)
  }

  // MARK: Helpers

  private func makeSUT() -> CurrencyConverterViewModel {
    let sut = CurrencyConverterViewModel()
    return sut
  }
}
