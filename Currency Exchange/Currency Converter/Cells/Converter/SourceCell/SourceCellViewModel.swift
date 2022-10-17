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

  private var sourceCurrencySubject: BehaviorRelay<Currency>
  private(set) var sourceCurrencyAmountSubject: BehaviorRelay<Double?>
  private var validator: InputTextValidator

  init(
    sourceCurrencySubject: BehaviorRelay<Currency>,
    sourceCurrencyAmountSubject: BehaviorRelay<Double?>,
    validator: InputTextValidator = InputAmountValidator()
  ) {
    self.sourceCurrencySubject = sourceCurrencySubject
    self.sourceCurrencyAmountSubject = sourceCurrencyAmountSubject
    self.validator = validator
  }

  func validateInputAmount(_ stringAmount: String) -> Bool {
    return validator.validateInput(stringAmount)
  }
}
