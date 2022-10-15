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
}
