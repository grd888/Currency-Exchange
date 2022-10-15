//
//  CurrencyConverterViewModelTests.swift
//  Currency ExchangeTests
//
//  Created by Greg Delgado on 10/15/22.
//

@testable import Currency_Exchange
import RxSwift
import RxCocoa
import XCTest

final class CurrencyConverterViewModelTests: XCTestCase {
  typealias Section = CurrencyConverterViewModel.Section
  // swiftlint:disable:next implicitly_unwrapped_optional
  var disposeBag: DisposeBag!

  override func setUp() {
    super.setUp()
    disposeBag = DisposeBag()
  }

  override func tearDown() {
    super.tearDown()
    disposeBag = nil
  }


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

  func test_currentBalanceWithOneCurrencyInitialized() {
    let account = UserAccount(initialBalance: [.EUR: 100000])
    let sut = makeSUT(account)
    let exp = expectation(description: "Waiting for observable...")
    sut.currentBalanceObservable
      .subscribe { balances in
        XCTAssertEqual(account.balance[.EUR], balances[.EUR])
        XCTAssertEqual(account.balance[.USD], 0)
        XCTAssertEqual(account.balance[.JPY], 0)
        exp.fulfill()
      }
      .disposed(by: disposeBag)
    wait(for: [exp], timeout: 1.0)
  }

  func test_currentBalance() {
    let account = UserAccount(initialBalance: [
      .EUR: 100000,
      .USD: 2000,
      .JPY: 30000
    ])
    let sut = makeSUT(account)
    let exp = expectation(description: "Waiting for observable...")
    sut.currentBalanceObservable
      .subscribe { balances in
        XCTAssertEqual(account.balance[.EUR], balances[.EUR])
        XCTAssertEqual(account.balance[.USD], balances[.USD])
        XCTAssertEqual(account.balance[.JPY], balances[.JPY])
        exp.fulfill()
      }
      .disposed(by: disposeBag)
    wait(for: [exp], timeout: 1.0)
  }

  // MARK: Helpers

  private func makeSUT(_ account: UserAccount? = nil) -> CurrencyConverterViewModel {
    let sut = CurrencyConverterViewModel(userAccount: account ?? makeUserAccount())
    return sut
  }

  private func makeUserAccount() -> UserAccount {
    return UserAccount()
  }
}
