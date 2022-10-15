//
//  Currency.swift
//  Currency Exchange
//
//  Created by Greg Delgado on 10/15/22.
//

import Foundation

typealias AccountBalance = [Currency: Decimal]

enum Currency: Int, CaseIterable {
  case EUR
  case USD
  case JPY
}

extension Currency {
  func toString() -> String {
    switch self {
    case .EUR:
      return "EUR"
    case .USD:
      return "USD"
    case .JPY:
      return "JPY"
    }
  }
  func hasDecimal() -> Bool {
    switch self {
    case .EUR:
      return true
    case .USD:
      return true
    case .JPY:
      return false
    }
  }
}

extension Currency: Comparable {
  static func < (lhs: Currency, rhs: Currency) -> Bool {
    return lhs.rawValue < rhs.rawValue
  }
}

extension AccountBalance {
  func numberOfCurrencies() -> Int {
    return self.count
  }
}
