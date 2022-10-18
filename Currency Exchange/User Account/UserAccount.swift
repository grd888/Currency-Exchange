//
//  UserAccount.swift
//  Currency Exchange
//
//  Created by Greg Delgado on 10/15/22.
//

import Foundation

class UserAccount {
  private(set) lazy var balance: AccountBalance = defaultBalance()
  private(set) var transactionCount = 0

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

  func update(transaction: TransactionType) throws -> AccountBalance {
    transactionCount += 1
    switch transaction {
    case let .sell(
      source: (srcCurrency, srcAmount),
      receive: (rcvCurrency, rcvAmount)):

      let currentSourceBalance = balance[srcCurrency] ?? 0
      let currentReceiveBalance = balance[rcvCurrency] ?? 0
      guard (currentSourceBalance - srcAmount) >= 0 else {
        throw UserAccountError.negativeBalance
      }
      balance[srcCurrency] = currentSourceBalance - srcAmount
      balance[rcvCurrency] = currentReceiveBalance + rcvAmount
      return balance
    }
  }

  private func defaultBalance() -> AccountBalance {
    return Currency.allCases.reduce(into: AccountBalance()) { balance, currency in
      balance[currency] = 0.0
    }
  }
}

enum TransactionType {
  case sell(source: (Currency, Decimal),
    receive: (Currency, Decimal))
}
