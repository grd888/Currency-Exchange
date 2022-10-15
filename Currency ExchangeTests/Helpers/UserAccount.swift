//
//  UserAccount.swift
//  Currency ExchangeTests
//
//  Created by Greg Delgado on 10/15/22.
//

@testable import Currency_Exchange
import Foundation

func makeUserAccount(balance: AccountBalance? = nil) -> UserAccount {
  return UserAccount(initialBalance: balance)
}
