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
  private var sourceCurrency: BehaviorRelay<Currency>
  private var destinationCurrency: BehaviorRelay<Currency>

  private var configuration: [Section: Int] = [
    .balances: 1,
    .converter: 2,
    .submit: 1
  ]

  private var userAccount: UserAccount

  init(userAccount: UserAccount = UserAccount()) {
    self.userAccount = userAccount

    currentBalance = BehaviorRelay(value: userAccount.balance)
    sourceCurrency = BehaviorRelay(value: userAccount.defaultSellCurrency())
    destinationCurrency = BehaviorRelay(value: userAccount.defaultBuyCurrency())
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

  func getSourceCellViewModel() -> SourceCellViewModel {
    return SourceCellViewModel(sourceCurrencySubject: sourceCurrency)
  }
}

// MARK: - PickerView data
extension CurrencyConverterViewModel {
  func numberOfCurrencies() -> Int {
    return userAccount.currencyList().count
  }
  func currencyName(forIndex index: Int) -> String {
    return userAccount.currencyList()[index].toString()
  }
  func currentSourceCurrencyIndex() -> Int {
    return userAccount.currencyList()
      .firstIndex(of: sourceCurrency.value) ?? 0
  }
  func selectSourceCurrency(atIndex index: Int) {
    let currency = userAccount.currencyList()[index]
    sourceCurrency.accept(currency)
  }
  func selectDestinationCurrency(atIndex index: Int) {
    let currency = userAccount.currencyList()[index]
    sourceCurrency.accept(currency)
  }
}
