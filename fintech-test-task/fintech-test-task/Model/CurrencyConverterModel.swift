//
//  CurrencyConverterModel.swift
//  fintech-test-task
//
//  Created by Vladyslav Sabelnikov on 16.12.2024.
//

import Foundation

struct CurrencyConverterModel {
    var fromCurrency: String
    var toCurrency: String
    var fromAmount: Double

    func convert(completion: @escaping (Result<Double, Error>) -> Void) {
        let urlString = "http://api.evp.lt/currency/commercial/exchange/\(fromAmount)-\(fromCurrency)/\(toCurrency)/latest"
        guard let url = URL(string: urlString) else {
            completion(.failure(NetworkError.invalidURL))
            return
        }

        NetworkManager.shared.performRequest(url: url) { result in
            switch result {
            case .success(let dataString):
                if let dict = dataString.toJSON() as? [String:AnyObject] {
                    guard let amount = dict["amount"] as? Substring else {
                        let error = NSError(domain: "", code: 10001, userInfo: [ NSLocalizedDescriptionKey: dict["error_description"] as? String ?? "Something went wrong"])
                        completion(.failure(error))
                        return
                    }
                    if let convertedAmount = Double(amount) {
                        completion(.success(convertedAmount))
                    } else {
                        completion(.failure(NetworkError.invalidData))
                    }
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}

enum NetworkError: Error {
    case invalidURL
    case invalidData
    case networkError
}

