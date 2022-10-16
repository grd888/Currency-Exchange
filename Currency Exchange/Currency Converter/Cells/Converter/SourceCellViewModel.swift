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
      .map { String($0) }
      .asObservable()
  }
  private var sourceCurrencySubject: BehaviorRelay<Currency>
  private var sourceCurrencyAmountSubject: BehaviorRelay<Double>

  init(
    sourceCurrencySubject: BehaviorRelay<Currency>,
    sourceCurrencyAmountSubject: BehaviorRelay<Double>
  ) {
    self.sourceCurrencySubject = sourceCurrencySubject
    self.sourceCurrencyAmountSubject = sourceCurrencyAmountSubject
  }
}
