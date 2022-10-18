//
//  ConverterProtocol.swift
//  Currency Exchange
//
//  Created by Greg Delgado on 10/19/22.
//

import Foundation

protocol ConverterProtocol {
  func convert(from: (Currency, Double), receive: Currency, completion: @escaping ((Result<Double, ConversionError>) -> Void))
}

enum ConversionError: Error {
  case conversionFailed
}
