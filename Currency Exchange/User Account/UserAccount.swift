//
//  UserAccount.swift
//  Currency Exchange
//
//  Created by Greg Delgado on 10/15/22.
//

import Foundation

class UserAccount {
  var balances: [Currency: Decimal] = [
    .EUR: 0.0,
    .USD: 0.0,
    .JPY: 0.0
  ]
}
