//
//  InputAmountValidator.swift
//  Currency Exchange
//
//  Created by Greg Delgado on 10/17/22.
//

import Foundation

struct InputAmountValidator: InputTextValidator {
  func validateInput(_ text: String) -> Bool {
    if text == "." {
      return false
    }
    if text.range(of: "^[0-9|\\.]*$", options: .regularExpression) == nil {
      return false
    }
    if text.filter({ $0 == "." }).count > 1 {
      return false
    }
    if text.contains(".") && text.range(of: "\\.\\d\\d\\d+$", options: .regularExpression) != nil {
      return false
    }
    return true
  }
}
