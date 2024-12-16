//
//  NetworkManager.swift
//  fintech-test-task
//
//  Created by Vladyslav Sabelnikov on 16.12.2024.
//

import Foundation

class NetworkManager {
    static let shared = NetworkManager()

    func performRequest(url: URL, completion: @escaping (Result<String, Error>) -> Void) {
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }

            guard let data = data, let result = String(data: data, encoding: .utf8) else {
                completion(.failure(NetworkError.invalidData))
                return
            }
            
            completion(.success(result))
        }
        task.resume()
    }
}
