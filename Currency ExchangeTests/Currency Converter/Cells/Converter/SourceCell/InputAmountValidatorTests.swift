//
//  InputAmountValidatorTests.swift
//  Currency ExchangeTests
//
//  Created by Greg Delgado on 10/17/22.
//

import XCTest

final class InputAmountValidatorTests: XCTestCase {
  func test_validate_withNonNumericInput_returnsTrue() {
    XCTAssertFalse(makeSUT().validateInput("X"))
  }
  func test_validate_withAlphaNumericInput_retursFalse() {
    XCTAssertFalse(makeSUT().validateInput("X123"))
  }
  func test_validate_withInputZero_returnsTrue() {
    XCTAssertTrue(makeSUT().validateInput("0"))
  }
  func test_validate_withNumberAndOneDecimal_returnsTrue() {
    XCTAssertTrue(makeSUT().validateInput("0.5"))
  }
  func test_validate_withNumberAndOneDecimalWithZero_returnsTrue() {
    XCTAssertTrue(makeSUT().validateInput("0.50"))
  }
  func test_validate_withNumberEndingInDecimal_returnsTrue() {
    XCTAssertTrue(makeSUT().validateInput("5."))
  }
  func test_validate_withNumberAndTwoDecimals_returnsFalse() {
    XCTAssertFalse(makeSUT().validateInput("0..5"))
  }

  // MARK: - Helpers
  private func makeSUT() -> InputTextValidator {
    return InputAmountValidator()
  }
}
