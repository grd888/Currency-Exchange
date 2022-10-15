//
//  SourceCellViewModelTests.swift
//  Currency ExchangeTests
//
//  Created by Greg Delgado on 10/15/22.
//

@testable import Currency_Exchange
import RxSwift
import RxCocoa
import XCTest

final class SourceCellViewModelTests: XCTestCase {
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

  func test_sourceCurrencyObservable() {
    let currencySubject = BehaviorRelay(value: Currency.JPY)
    let sut = SourceCellViewModel(sourceCurrencySubject: currencySubject)
    let exp = expectation(description: "Waiting for observable...")

    // swiftlint:disable:next trailing_closure
    sut.sourceCurrencyObservable
      .subscribe(onNext: { currency in
        XCTAssertEqual(currency, "JPY ")
        exp.fulfill()
      })
      .disposed(by: disposeBag)
    wait(for: [exp], timeout: 1.0)
  }

  func test_setCurrency() {
    let currencySubject = BehaviorRelay(value: Currency.JPY)
    let sut = SourceCellViewModel(sourceCurrencySubject: currencySubject)
    let exp = expectation(description: "Waiting for observable...")
    // swiftlint:disable:next trailing_closure
    sut.sourceCurrencyObservable
      .skip(1)
      .subscribe(onNext: { currency in
        XCTAssertEqual(currency, "USD ")
        exp.fulfill()
      })
      .disposed(by: disposeBag)
    sut.setCurrency(Currency.USD)
    wait(for: [exp], timeout: 1.0)
  }
}
