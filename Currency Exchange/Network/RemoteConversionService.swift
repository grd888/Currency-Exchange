//
//  RemoteConversionService.swift
//  Currency Exchange
//
//  Created by Greg Delgado on 10/19/22.
//

import Foundation

class RemoteConversionService: ConverterProtocol {
  func convert(from: (Currency, Double), receive: Currency, completion: @escaping ((Result<Double, ConversionError>) -> Void)) {
    // swiftlint:disable force_unwrapping
    let url = URL(string: "http://api.evp.lt/currency/commercial/exchange/\(from.1)-\(from.0.toString())/\(receive.toString())/latest")!
    let urlRequest = URLRequest(url: url)
    URLSession.shared.dataTask(with: urlRequest) { data, _, _ in
      DispatchQueue.main.async {
        if let data = data {
          do {
            let object = try JSONDecoder().decode(Conversion.self, from: data)
            if let amount = Double(object.amount) {
              completion(.success(amount))
            } else {
              completion(.failure(ConversionError.conversionFailed))
            }
          } catch {
            completion(.failure(ConversionError.conversionFailed))
          }
        } else {
          completion(.failure(ConversionError.conversionFailed))
        }
      }
    }
    .resume()
  }
}
