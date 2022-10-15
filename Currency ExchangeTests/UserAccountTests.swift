//
//  UserAccountTests.swift
//  Currency ExchangeTests
//
//  Created by Greg Delgado on 10/15/22.
//

@testable import Currency_Exchange
import XCTest

final class UserAccountTests: XCTestCase {
    func testUserAccountReturnsCurrencyBalances() {
        let sut = UserAccount()
        XCTAssertEqual(sut.balances, [
            Currency.usd: 0.0,
            Currency.eur: 0.0,
            Currency.jpy: 0.0
        ])
    }
}
