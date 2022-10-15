//
//  UserAccount.swift
//  Currency Exchange
//
//  Created by Greg Delgado on 10/15/22.
//

import Foundation

class UserAccount {
  private(set) lazy var balance: AccountBalance = defaultBalance()

  init(initialBalance: AccountBalance? = nil) {
    if let initialBalance = initialBalance {
      balance = initialBalance
    }
  }

  private func defaultBalance() -> AccountBalance {
    return Currency.allCases.reduce(into: AccountBalance()) { balance, currency in
      balance[currency] = 0.0
    }
  }
}
