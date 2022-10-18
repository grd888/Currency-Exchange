//
//  CommissionCalculator.swift
//  Currency Exchange
//
//  Created by Greg Delgado on 10/18/22.
//

import Foundation

protocol CommissionCalculator {
  func computeCommission(
    forCurrency currency: Currency,
    amount: Double,
    transactionCount: Int
  ) -> Double
}
