//
//  CurrencyConverterViewModel.swift
//  Currency Exchange
//
//  Created by Greg Delgado on 10/15/22.
//

import RxSwift
import RxCocoa
import Foundation

class CurrencyConverterViewModel {
  var currentBalanceObservable: Observable<AccountBalance> {
    return currentBalance.asObservable()
  }

  enum Section: Int, CaseIterable {
    case balances
    case converter
    case submit
  }

  private var currentBalance: BehaviorRelay<AccountBalance>

  private var configuration: [Section: Int] = [
    .balances: 1,
    .converter: 2,
    .submit: 1
  ]

  private var userAccount: UserAccount

  init(userAccount: UserAccount = UserAccount()) {
    self.userAccount = userAccount

    currentBalance = BehaviorRelay(value: userAccount.balance)
  }

  func numberOfSections() -> Int {
    return Section.allCases.count
  }

  func numberOfRowsInSection(_ index: Int) -> Int {
    guard let section = Section(rawValue: index), let count = configuration[section] else {
      return 0
    }
    return count
  }

  func getBalancesViewModel() -> BalancesCellViewModel {
    return BalancesCellViewModel(currentBalanceObservable: currentBalance)
  }
}
