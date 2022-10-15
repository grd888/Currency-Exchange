//
//  BalancesCellViewModelTests.swift
//  Currency ExchangeTests
//
//  Created by Greg Delgado on 10/15/22.
//

@testable import Currency_Exchange
import RxSwift
import RxCocoa
import XCTest

final class BalancesCellViewModelTests: XCTestCase {
  func test_numberOfItems() {
    let account = makeUserAccount()
    let currentBalance = BehaviorRelay(value: account.balance)
    let sut = BalancesCellViewModel(currentBalanceObservable: currentBalance)
    XCTAssertEqual(sut.numberOfItems(), 3)
  }

  func test_itemForIndex() {
    let balance: AccountBalance = [
      .EUR: 1234.56,
      .USD: 5678,
      .JPY: 99990
    ]
    let currentBalance = BehaviorRelay(value: balance)
    let sut = BalancesCellViewModel(currentBalanceObservable: currentBalance)
    XCTAssertEqual(sut.item(forIndex: 0), "1234.56 EUR")
    XCTAssertEqual(sut.item(forIndex: 1), "5678.00 USD")
    XCTAssertEqual(sut.item(forIndex: 2), "99990 JPY")
  }
}
