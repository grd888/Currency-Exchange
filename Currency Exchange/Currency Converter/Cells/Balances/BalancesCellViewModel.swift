//
//  BalancesCellViewModel.swift
//  Currency ExchangeTests
//
//  Created by Greg Delgado on 10/15/22.
//

import RxSwift
import RxCocoa
import Foundation

struct BalancesCellViewModel {
  var currentBalance: BehaviorRelay<AccountBalance>
  var formatter: CurrencyFormatting

  init(currentBalanceObservable: BehaviorRelay<AccountBalance>, formatter: CurrencyFormatting = CurrencyFormatter()) {
    self.currentBalance = currentBalanceObservable
    self.formatter = formatter
  }

  func numberOfItems() -> Int {
    return currentBalance.value.numberOfCurrencies()
  }

  func item(forIndex index: Int) -> String {
    let allBalances = currentBalance.value.sorted(by: <)
    let balance = allBalances[index]
    let double = Double(truncating: balance.value as NSNumber)
    let doubleString = (try? formatter.format(amount: double, in: balance.key)) ?? "---"
    return "\(doubleString) \(balance.key.toString())"
  }
}
