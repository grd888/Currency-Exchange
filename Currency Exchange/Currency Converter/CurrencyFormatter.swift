//
//  CurrencyFormatter.swift
//  Currency Exchange
//
//  Created by Greg Delgado on 10/16/22.
//

import Foundation

enum FormatError: Error {
  case invalidAmount
}

struct CurrencyFormatter {
  func format(amount: Double, in currency: Currency) throws -> String {
    if currency.hasDecimal() {
      return String(format: "%0.2f", amount)
    }
    guard String(format: "%0.2f", amount).hasSuffix(".00") else {
      throw FormatError.invalidAmount
    }
    return String(format: "%0.0f", amount)
  }
}
