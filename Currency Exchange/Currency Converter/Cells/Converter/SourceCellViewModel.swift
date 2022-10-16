//
//  SourceCellViewModel.swift
//  Currency Exchange
//
//  Created by Greg Delgado on 10/15/22.
//

import RxSwift
import RxCocoa
import Foundation

struct SourceCellViewModel {
  var sourceCurrencyObservable: Observable<String> {
    return sourceCurrencySubject.map { $0.toString() + " " }
  }
  var sourceCurrencyAmountObservable: Observable<String?> {
    return sourceCurrencyAmountSubject
      .map { try? formatter.format(
        amount: $0,
        in: sourceCurrencySubject.value)
      }
      .asObservable()
  }
  private var sourceCurrencySubject: BehaviorRelay<Currency>
  private var sourceCurrencyAmountSubject: BehaviorRelay<Double>
  private var formatter: CurrencyFormatting

  init(
    sourceCurrencySubject: BehaviorRelay<Currency>,
    sourceCurrencyAmountSubject: BehaviorRelay<Double>,
    formatter: CurrencyFormatting = CurrencyFormatter()
  ) {
    self.sourceCurrencySubject = sourceCurrencySubject
    self.sourceCurrencyAmountSubject = sourceCurrencyAmountSubject
    self.formatter = formatter
  }
}
