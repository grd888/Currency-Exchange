//
//  RemoteConversionService.swift
//  Currency Exchange
//
//  Created by Greg Delgado on 10/19/22.
//

import Foundation

class RemoteConversionService: ConverterProtocol {
  func convert(from: (Currency, Double), receive: Currency, completion: @escaping ((Result<Double, ConversionError>) -> Void)) {
    completion(.success(130.0))
  }
}
