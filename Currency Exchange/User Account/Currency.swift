//
//  Currency.swift
//  Currency Exchange
//
//  Created by Greg Delgado on 10/15/22.
//

import Foundation

typealias AccountBalance = [Currency: Decimal]

enum Currency: String, CaseIterable {
  case EUR
  case USD
  case JPY
}

extension AccountBalance {
  func numberOfCurrencies() -> Int {
    return self.count
  }
}
