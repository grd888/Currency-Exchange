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

  func defaultSellCurrency() -> Currency {
    var sellCurrency: Currency?
    for currency in currencyList() where balance[currency] ?? 0 > 0 {
      sellCurrency = currency
      break
    }
    return sellCurrency ?? Currency.allCases[0]
  }

  func defaultBuyCurrency() -> Currency {
    let dest = currencyList().first { $0 != defaultSellCurrency() }
    return dest ?? currencyList()[0]
  }

  func currencyList() -> [Currency] {
    return balance.keys.sorted()
  }

  private func defaultBalance() -> AccountBalance {
    return Currency.allCases.reduce(into: AccountBalance()) { balance, currency in
      balance[currency] = 0.0
    }
  }
}
