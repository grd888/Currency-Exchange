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

  init(currentBalanceObservable: BehaviorRelay<AccountBalance>) {
    self.currentBalance = currentBalanceObservable
  }

  func numberOfItems() -> Int {
    return currentBalance.value.numberOfCurrencies()
  }

  func item(forIndex index: Int) -> String {
    let allBalances = currentBalance.value.sorted(by: <)
    let balance = allBalances[index]
    let double = Double(truncating: balance.value as NSNumber)
    let doubleString = balance.key.hasDecimal() ? String(format: "%.2f", double) : String(format: "%.0f", double)
    return "\(doubleString) \(balance.key.toString())"
  }
}
