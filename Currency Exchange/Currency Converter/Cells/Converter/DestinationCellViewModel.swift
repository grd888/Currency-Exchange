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
  private var destinationCurrencySubject: BehaviorRelay<Currency>

  init(destinationCurrencySubject: BehaviorRelay<Currency>) {
    self.destinationCurrencySubject = destinationCurrencySubject
  }
}
