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

  init(sourceCurrencySubject: BehaviorRelay<Currency>) {
    self.sourceCurrencySubject = sourceCurrencySubject
  }
}
