//
//  DestinationCellViewModel.swift
//  Currency Exchange
//
//  Created by Greg Delgado on 10/16/22.
//

import RxSwift
import RxCocoa
import Foundation

struct DestinationCellViewModel {
  var destinationCurrencyObservable: Observable<String> {
    return destinationCurrencySubject.map { $0.toString() + " " }
  }
  var destinationCurrencyAmountObservable: Observable<String?> {
    return destinationCurrencyAmountSubject
      .map { try? formatter.format(
        amount: $0,
        in: destinationCurrencySubject.value)
      }
      .asObservable()
  }
  private var destinationCurrencySubject: BehaviorRelay<Currency>
  private var destinationCurrencyAmountSubject: BehaviorRelay<Double>
  private var formatter: CurrencyFormatting

  init(
    destinationCurrencySubject: BehaviorRelay<Currency>,
    destinationCurrencyAmountSubject: BehaviorRelay<Double>,
    formatter: CurrencyFormatting = CurrencyFormatter()
  ) {
    self.destinationCurrencySubject = destinationCurrencySubject
    self.destinationCurrencyAmountSubject = destinationCurrencyAmountSubject
    self.formatter = formatter
  }
}
