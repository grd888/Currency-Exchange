//
//  FixedFiveCommission.swift
//  Currency Exchange
//
//  Created by Greg Delgado on 10/18/22.
//

import Foundation

struct FixedFiveCommission: CommissionCalculator {
  let rate: Double = 0.007

  func computeCommission(
    forCurrency currency: Currency,
    amount: Double,
    transactionCount: Int
  ) -> Double {
    if transactionCount <= 5 {
      return 0
    }
    if currency.hasDecimal() {
      return round((amount * rate) * 100.0) / 100.0
    } else {
      return round(amount * rate)
    }
  }
}
