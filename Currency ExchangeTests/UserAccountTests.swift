//
//  UserAccountTests.swift
//  Currency ExchangeTests
//
//  Created by Greg Delgado on 10/15/22.
//

@testable import Currency_Exchange
import XCTest

final class UserAccountTests: XCTestCase {
  func testDefaultInitReturnsZeroBalanceForAllCurrencies() {
    let sut = UserAccount()
    XCTAssertEqual(sut.balance, getDefaultBalance())
  }

  // MARK: Helpers
  private func getDefaultBalance() -> AccountBalance {
    return Currency.allCases.reduce(into: AccountBalance()) { balance, currency in
      balance[currency] = 0.0
    }
  }
}
