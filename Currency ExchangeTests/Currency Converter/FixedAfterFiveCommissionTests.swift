//
//  FixedAfterFiveCommissionTests.swift
//  Currency ExchangeTests
//
//  Created by Greg Delgado on 10/18/22.
//

@testable import Currency_Exchange
import XCTest

final class FixedAfterFiveCommissionTests: XCTestCase {
  func test_zeroInput_returnsZero() {
    let sut = FixedFiveCommission()
    let commission = sut.computeCommission(forCurrency: .EUR, amount: 0, transactionCount: 1)
    XCTAssertEqual(commission, 0)
  }
  func test_positiveInput_firstFiveTransactions_returnsZero() {
    let sut = FixedFiveCommission()
    XCTAssertEqual(sut.computeCommission(forCurrency: .EUR, amount: 100, transactionCount: 1), 0)
    XCTAssertEqual(sut.computeCommission(forCurrency: .EUR, amount: 100, transactionCount: 2), 0)
    XCTAssertEqual(sut.computeCommission(forCurrency: .EUR, amount: 100, transactionCount: 3), 0)
    XCTAssertEqual(sut.computeCommission(forCurrency: .EUR, amount: 100, transactionCount: 4), 0)
    XCTAssertEqual(sut.computeCommission(forCurrency: .EUR, amount: 100, transactionCount: 5), 0)
  }
  func test_positiveInput_firstSixOrMoreTransactions_returns0_7Percent() {
    let sut = FixedFiveCommission()
    XCTAssertEqual(sut.computeCommission(forCurrency: .EUR, amount: 100, transactionCount: 6), 0.7)
    XCTAssertEqual(sut.computeCommission(forCurrency: .EUR, amount: 1234, transactionCount: 7), 8.64)
  }
  func test_positiveInputForJPY_firstSixOrMoreTransactions_returns0_7PercentInteger() {
    let sut = FixedFiveCommission()
    XCTAssertEqual(sut.computeCommission(forCurrency: .JPY, amount: 10500, transactionCount: 6), 74)
    XCTAssertEqual(sut.computeCommission(forCurrency: .JPY, amount: 10000, transactionCount: 6), 70)
  }
}
