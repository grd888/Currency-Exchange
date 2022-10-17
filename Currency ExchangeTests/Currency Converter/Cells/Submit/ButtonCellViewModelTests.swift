//
//  ButtonCellViewModelTests.swift
//  Currency ExchangeTests
//
//  Created by Greg Delgado on 10/17/22.
//

@testable import Currency_Exchange
import RxSwift
import RxCocoa
import XCTest

final class ButtonCellViewModelTests: XCTestCase {
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

  func test_enableButtonObservable() {
    let enableSubject = BehaviorRelay<Bool>(value: false)
    let buttonTapSubject = PublishSubject<Void>()
    let sut = ButtonCellViewModel(enableButtonObservable: enableSubject.asObservable(), buttonSubject: buttonTapSubject)
    let exp = expectation(description: "Waiting...")
    // swiftlint:disable:next trailing_closure
    sut.enableButtonObservable
      .skip(1)
      .subscribe(onNext: { enabled in
        XCTAssertTrue(enabled)
        exp.fulfill()
      })
      .disposed(by: disposeBag)

    enableSubject.accept(true)
    wait(for: [exp], timeout: 1.0)
  }
}
