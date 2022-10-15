//
//  UserAccountTests.swift
//  Currency ExchangeTests
//
//  Created by Greg Delgado on 10/15/22.
//

@testable import Currency_Exchange
import XCTest

final class UserAccountTests: XCTestCase {
  func test_defaultInit_returnsZeroBalanceForAllCurrencies() {
    let sut = UserAccount()
    XCTAssertEqual(sut.balance, getDefaultBalance())
  }

  func test_initializeWithOneCurrency_returnsCorrectInitialBalances() {
    let sut = UserAccount(initialBalance: [.EUR: 1000])
    XCTAssertEqual(sut.balance[.EUR], 1000.00)
    XCTAssertEqual(sut.balance[.USD], 0.0)
    XCTAssertEqual(sut.balance[.JPY], 0.0)
  }

  func test_initializeWithTwoCurrencies_returnsCorrectInitialBalances() {
    let sut = UserAccount(initialBalance: [.EUR: 1_000, .JPY: 2_000_000])
    XCTAssertEqual(sut.balance[.EUR], 1000)
    XCTAssertEqual(sut.balance[.USD], 0.0)
    XCTAssertEqual(sut.balance[.JPY], 2000000)
  }

  func test_initializeWithThreeCurrencies_returnsCorrectInitialBalances() {
    let sut = UserAccount(initialBalance: [.EUR: 1_000, .JPY: 2_000_000, .USD: 3_000])
    XCTAssertEqual(sut.balance[.EUR], 1000)
    XCTAssertEqual(sut.balance[.USD], 3000)
    XCTAssertEqual(sut.balance[.JPY], 2000000)
  }

  // MARK: Helpers
  private func getDefaultBalance() -> AccountBalance {
    return Currency.allCases.reduce(into: AccountBalance()) { balance, currency in
      balance[currency] = 0.0
    }
  }
}
