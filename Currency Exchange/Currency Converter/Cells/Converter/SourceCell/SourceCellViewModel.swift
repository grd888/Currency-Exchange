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
  var resetAmountObservable: Observable<String?> {
    return resetAmountSubject.asObservable()
  }

  private var sourceCurrencySubject: BehaviorRelay<Currency>
  private(set) var sourceCurrencyAmountSubject: BehaviorRelay<Double?>
  private(set) var resetAmountSubject: PublishRelay<String?>
  private var validator: InputTextValidator

  init(
    sourceCurrencySubject: BehaviorRelay<Currency>,
    sourceCurrencyAmountSubject: BehaviorRelay<Double?>,
    resetAmountSubject: PublishRelay<String?>,
    validator: InputTextValidator = InputAmountValidator()
  ) {
    self.sourceCurrencySubject = sourceCurrencySubject
    self.sourceCurrencyAmountSubject = sourceCurrencyAmountSubject
    self.resetAmountSubject = resetAmountSubject
    self.validator = validator
  }

  func validateInputAmount(_ stringAmount: String) -> Bool {
    return validator.validateInput(stringAmount)
  }
}
