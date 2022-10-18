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
  var enableSubmitObservable: Observable<Bool> {
    return enableSubmitSubject.asObservable()
  }

  enum Section: Int, CaseIterable {
    case balances
    case converter
    case submit
  }

  private(set) var currentBalance: BehaviorRelay<AccountBalance>
  private(set) var sourceCurrency: BehaviorRelay<Currency>
  private(set) var destinationCurrency: BehaviorRelay<Currency>
  private(set) var commissionSubject = BehaviorRelay<Double>(value: 0)
  private(set) var sourceCurrencyAmount = BehaviorRelay<Double?>(value: nil)
  private(set) var destinationCurrencyAmount = BehaviorRelay<Double>(value: 0)
  private(set) var enableSubmitSubject = BehaviorRelay<Bool>(value: false)
  private(set) var buttonTapSubject = PublishSubject<Void>()
  private var disposeBag = DisposeBag()

  private var configuration: [Section: Int] = [
    .balances: 1,
    .converter: 2,
    .submit: 1
  ]

  private var userAccount: UserAccount
  private var commissionCalculator: CommissionCalculator

  init(
    userAccount: UserAccount = UserAccount(),
    commissionCalculator: CommissionCalculator = FixedFiveCommission()
  ) {
    self.userAccount = userAccount
    self.commissionCalculator = commissionCalculator

    currentBalance = BehaviorRelay(value: userAccount.balance)
    sourceCurrency = BehaviorRelay(value: userAccount.defaultSellCurrency())
    destinationCurrency = BehaviorRelay(value: userAccount.defaultBuyCurrency())

    setupButtonObservers()
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
    return SourceCellViewModel(
      sourceCurrencySubject: sourceCurrency,
      sourceCurrencyAmountSubject: sourceCurrencyAmount
    )
  }

  func getDestinationCellViewModel() -> DestinationCellViewModel {
    return DestinationCellViewModel(
      destinationCurrencySubject: destinationCurrency,
      destinationCurrencyAmountSubject: destinationCurrencyAmount
    )
  }

  func getButtonCellViewModel() -> ButtonCellViewModel {
    return ButtonCellViewModel(enableButtonObservable: enableSubmitObservable, buttonSubject: buttonTapSubject)
  }

  func updateUserAccount(transaction: TransactionType) {
    do {
      currentBalance.accept(try userAccount.update(transaction: transaction))
    } catch {
      print("Did not update User account:", error)
    }
  }

  func setupButtonObservers() {
    Observable.combineLatest(
      commissionSubject.asObservable(),
      currentBalance.asObservable(),
      sourceCurrencyAmount.asObservable(),
      sourceCurrency.asObservable(),
      destinationCurrency.asObservable()
    )
    .subscribe { commission, balances, amount, src, dst in
      let currencyBalance = balances[src] ?? 0
      let inputAmount = amount ?? 0

      let valid = currencyBalance.doubleValue >= inputAmount + commission
        && inputAmount > 0
        && src != dst

      self.enableSubmitSubject.accept(valid)
    }
    .disposed(by: disposeBag)

    // swiftlint:disable:next trailing_closure
    buttonTapSubject.subscribe(onNext: {
      print("Tap")
    })
    .disposed(by: disposeBag)

    // swiftlint:disable:next trailing_closure
    sourceCurrencyAmount
      .map { $0 ?? 0 }
      .subscribe(onNext: { [unowned self] amount in
        let currency = self.sourceCurrency.value
        let transactionCount = self.userAccount.transactionCount
        let commission = self.commissionCalculator.computeCommission(
          forCurrency: currency,
          amount: amount,
          transactionCount: transactionCount + 1)
        self.commissionSubject.accept(commission)
      })
      .disposed(by: disposeBag)
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
  func currentDestinationCurrencyIndex() -> Int {
    return userAccount.currencyList()
      .firstIndex(of: destinationCurrency.value) ?? 0
  }
  func selectSourceCurrency(atIndex index: Int) {
    let currency = userAccount.currencyList()[index]
    sourceCurrency.accept(currency)
  }
  func selectDestinationCurrency(atIndex index: Int) {
    let currency = userAccount.currencyList()[index]
    destinationCurrency.accept(currency)
  }
}
