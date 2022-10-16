//
//  CurrencyFormatterTests.swift
//  Currency ExchangeTests
//
//  Created by Greg Delgado on 10/16/22.
//

@testable import Currency_Exchange
import XCTest

final class CurrencyFormatterTests: XCTestCase {
  func test_format_withZeroInput() {
    let sut = CurrencyFormatter()
    XCTAssertEqual(try sut.format(amount: 0, in: .EUR), "0.00")
    XCTAssertEqual(try sut.format(amount: 0, in: .USD), "0.00")
    XCTAssertEqual(try sut.format(amount: 0, in: .JPY), "0")
  }
  func test_format_withIntegerInput() {
    let sut = CurrencyFormatter()
    XCTAssertEqual(try sut.format(amount: 10, in: .EUR), "10.00")
    XCTAssertEqual(try sut.format(amount: 20, in: .USD), "20.00")
    XCTAssertEqual(try sut.format(amount: 30, in: .JPY), "30")
  }
  func test_format_withSingleDecimalInput() {
    let sut = CurrencyFormatter()
    XCTAssertEqual(try sut.format(amount: 0.1, in: .EUR), "0.10")
    XCTAssertEqual(try sut.format(amount: 0.1, in: .USD), "0.10")
  }
  func test_formatJPY_withSingleDecimalInput_throwsError() throws {
    let sut = CurrencyFormatter()
    XCTAssertThrowsError(try sut.format(amount: 34.1, in: .JPY))
    XCTAssertEqual(try sut.format(amount: 34.1, in: .EUR), "34.10")
    XCTAssertEqual(try sut.format(amount: 34.1, in: .USD), "34.10")
  }
}
