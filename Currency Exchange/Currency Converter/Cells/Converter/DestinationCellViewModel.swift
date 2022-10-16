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
      .map { String($0) }
      .asObservable()
  }
  private var destinationCurrencySubject: BehaviorRelay<Currency>
  private var destinationCurrencyAmountSubject: BehaviorRelay<Double>

  init(
    destinationCurrencySubject: BehaviorRelay<Currency>,
    destinationCurrencyAmountSubject: BehaviorRelay<Double>
  ) {
    self.destinationCurrencySubject = destinationCurrencySubject
    self.destinationCurrencyAmountSubject = destinationCurrencyAmountSubject
  }
}
