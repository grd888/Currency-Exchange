//
//  ButtonCellViewModel.swift
//  Currency Exchange
//
//  Created by Greg Delgado on 10/17/22.
//

import RxSwift
import RxCocoa
import Foundation

struct ButtonCellViewModel {
  var enableButtonObservable: Observable<Bool>
  var buttonTapSubject: PublishSubject<Void>

  init(enableButtonObservable: Observable<Bool>, buttonSubject: PublishSubject<Void>) {
    self.enableButtonObservable = enableButtonObservable
    self.buttonTapSubject = buttonSubject
  }
}
