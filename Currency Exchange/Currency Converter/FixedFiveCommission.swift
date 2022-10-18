//
//  FixedFiveCommission.swift
//  Currency Exchange
//
//  Created by Greg Delgado on 10/18/22.
//

import Foundation

struct FixedFiveCommission: CommissionCalculator {
  let rate: Double
  let freeTransactionLimit: Int

  init(rate: Double = 0.007, freeTransactionsLimit: Int = 5) {
    self.rate = rate
    self.freeTransactionLimit = freeTransactionsLimit
  }

  func computeCommission(
    forCurrency currency: Currency,
    amount: Double,
    transactionCount: Int
  ) -> Double {
    if transactionCount <= freeTransactionLimit {
      return 0
    }
    if currency.hasDecimal() {
      return round((amount * rate) * 100.0) / 100.0
    } else {
      return round(amount * rate)
    }
  }
}
