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
}
