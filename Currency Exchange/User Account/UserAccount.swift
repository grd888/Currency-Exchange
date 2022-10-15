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
      for (currency, amount) in initialBalance {
        balance[currency] = amount
      }
    }
  }

  func sourceCurrency() -> Currency {
    var source: Currency?
    print(balance.keys.sorted())
    for currency in balance.keys.sorted() where balance[currency] ?? 0 > 0 {
      source = currency
      break
    }
    return source ?? Currency.allCases[0]
  }

  private func defaultBalance() -> AccountBalance {
    return Currency.allCases.reduce(into: AccountBalance()) { balance, currency in
      balance[currency] = 0.0
    }
  }
}
