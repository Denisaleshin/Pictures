//
//  NetworkManager.swift
//  Pictures
//
//  Created by Dzianis Alioshyn on 2/22/19.
//  Copyright © 2019 myOwn. All rights reserved.
//

import Foundation

enum NetworkError: Error {
    case commonError
}

final class NetworkManager {
    
    static let shared = NetworkManager()
    
    private init() {
        
    }
    
    func fetchFrom(_ url: String, completion:@escaping (Result<[Product]>) -> ()) {
        
        guard let url = URL(string: url) else { return }
        let request = URLRequest(url: url)
        
        let task = URLSession.shared.dataTask(with: request) { [weak self] data, response , error in
            
            // this is kind of error handling
            if let err = self?.errorFor(URLResponse: response, error: error) {
                completion(.failure(err))
            }
            guard let validData = data else {
                return
            }
            do {
                let cellContent = try JSONDecoder().decode(ProductInfoInfo.self, from: validData)
                completion(.success(cellContent.products))
            } catch {
                return completion(.failure(nil))
            }
        }
        task.resume()
    }
    
    private func errorFor(URLResponse response: URLResponse?,
                          error: Error?) -> Error? {
        // Error handling should be here.
        let error = NetworkError.commonError
        return error
    }
}
