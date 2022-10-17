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
      .map {
        if let amount = $0 {
          return try? formatter.format(amount: amount, in: sourceCurrencySubject.value)
        } else {
          return nil
        }
      }
      .asObservable()
  }
  private var sourceCurrencySubject: BehaviorRelay<Currency>
  private var sourceCurrencyAmountSubject: BehaviorRelay<Double?>
  private var formatter: CurrencyFormatting
  private var validator: InputTextValidator

  init(
    sourceCurrencySubject: BehaviorRelay<Currency>,
    sourceCurrencyAmountSubject: BehaviorRelay<Double?>,
    formatter: CurrencyFormatting = CurrencyFormatter(),
    validator: InputTextValidator = InputAmountValidator()
  ) {
    self.sourceCurrencySubject = sourceCurrencySubject
    self.sourceCurrencyAmountSubject = sourceCurrencyAmountSubject
    self.formatter = formatter
    self.validator = validator
  }

  func validateInputAmount(_ stringAmount: String) -> Bool {
    return validator.validateInput(stringAmount)
  }
}
