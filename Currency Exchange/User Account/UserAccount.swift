//
//  UserAccount.swift
//  Currency Exchange
//
//  Created by Greg Delgado on 10/15/22.
//

import Foundation

class UserAccount {
    var balances: [Currency: Decimal] = [
        .eur: 0.0,
        .usd: 0.0,
        .jpy: 0.0
    ]
}
