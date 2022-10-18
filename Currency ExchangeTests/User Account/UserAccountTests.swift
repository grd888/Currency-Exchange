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

  func test_initialize_transactionCountIsZero() {
    let sut = makeUserAccount()
    XCTAssertEqual(sut.transactionCount, 0)
  }

  func test_sourceCurrency_withPrimaryCurrencyNonZeroBalance() {
    let balance: AccountBalance = [.USD: 0, .JPY: 10000, .EUR: 1000]
    let sut = makeUserAccount(balance: balance)

    XCTAssertEqual(sut.defaultSellCurrency(), .EUR)
  }

  func test_sourceCurrency_withPrimaryCurrencyZeroBalance() {
    let balance: AccountBalance = [.USD: 0, .JPY: 10000, .EUR: 0]
    let sut = makeUserAccount(balance: balance)

    XCTAssertEqual(sut.defaultSellCurrency(), .JPY)
  }

  func test_sourceCurrency_withPrimaryCurrencyZeroBalanceUSDNonZero() {
    let balance: AccountBalance = [.USD: 100, .JPY: 10000, .EUR: 0]
    let sut = makeUserAccount(balance: balance)

    XCTAssertEqual(sut.defaultSellCurrency(), .USD)
  }

  func test_sourceCurrency_withAllBalancesZero() {
    let balance: AccountBalance = [.USD: 0, .JPY: 0, .EUR: 0]
    let sut = makeUserAccount(balance: balance)

    XCTAssertEqual(sut.defaultSellCurrency(), .EUR)
  }

  func test_BuyCurrency_withSellCurrencyEUR() {
    let balance: AccountBalance = [.USD: 0, .JPY: 10000, .EUR: 1000]
    let sut = makeUserAccount(balance: balance)

    XCTAssertEqual(sut.defaultSellCurrency(), .EUR)
    XCTAssertEqual(sut.defaultBuyCurrency(), .USD)
  }

  func test_BuyCurrency_withSellCurrencyUSD() {
    let balance: AccountBalance = [.USD: 100, .JPY: 10000, .EUR: 0]
    let sut = makeUserAccount(balance: balance)

    XCTAssertEqual(sut.defaultSellCurrency(), .USD)
    XCTAssertEqual(sut.defaultBuyCurrency(), .EUR)
  }

  func test_currencyList_returnsUserCurrenciesInOrder() {
    let balance: AccountBalance = [.USD: 0, .JPY: 0, .EUR: 0]
    let sut = makeUserAccount(balance: balance)

    XCTAssertEqual(sut.currencyList(), [.EUR, .USD, .JPY])
  }

  func test_update_withSellTransaction_increasesTransactionCount() throws {
    let balance: AccountBalance = [.USD: 0, .JPY: 0, .EUR: 1000]
    let sut = makeUserAccount(balance: balance)
    _ = try sut.update(transaction: .sell(
      source: (.EUR, 100),
      receive: (.USD, 130)
    ))
    XCTAssertEqual(sut.transactionCount, 1)
  }
  func test_update_withSellTransaction_reducesSourceBalance() throws {
    let balance: AccountBalance = [.USD: 0, .JPY: 0, .EUR: 1000]
    let sut = makeUserAccount(balance: balance)
    _ = try sut.update(transaction: .sell(
      source: (.EUR, 100),
      receive: (.USD, 130)
    ))
    XCTAssertEqual(sut.balance[.EUR], 900)
  }
  func test_update_withSellTransaction_increasesReceiveBalance() throws {
    let balance: AccountBalance = [.USD: 0, .JPY: 0, .EUR: 1000]
    let sut = makeUserAccount(balance: balance)
    _ = try sut.update(transaction: .sell(
      source: (.EUR, 100),
      receive: (.USD, 130)
    ))
    XCTAssertEqual(sut.balance[.USD], 130)
  }
  func test_update_withSellTransaction_ifSourceBecomesNegative_throwsError() {
    let eurBalance: Decimal = 1000
    let eurOneOverBalance = eurBalance + 1
    let balance: AccountBalance = [.USD: 0, .JPY: 0, .EUR: eurBalance]

    let sut = makeUserAccount(balance: balance)

    XCTAssertThrowsError(try sut.update(transaction: .sell(
      source: (.EUR, eurOneOverBalance),
      receive: (.USD, 130)
    )))
  }

  // MARK: Helpers
  private func getDefaultBalance() -> AccountBalance {
    return Currency.allCases.reduce(into: AccountBalance()) { balance, currency in
      balance[currency] = 0.0
    }
  }
}
