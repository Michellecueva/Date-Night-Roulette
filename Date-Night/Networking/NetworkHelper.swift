//
//  NetworkHelper.swift
//  iOS-CTA-KCampbell
//
//  Created by Krystal Campbell on 12/2/19.
//  Copyright © 2019 Krystal Campbell. All rights reserved.
//

import Foundation

enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
}

class NetworkHelper {
    
    // MARK: - Static Properties
    
    static let manager = NetworkHelper()
    
    // MARK: - Internal Properties
    
    
    func performDataTask(withUrl url: URL,
                         andHTTPBody body: Data? = nil,
                         andMethod httpMethod: HTTPMethod,
                         completionHandler: @escaping ((Result<Data, AppError>) -> Void)) {
        var request = URLRequest(url: url)
        request.httpMethod = httpMethod.rawValue
        request.httpBody = body
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
//        request.addValue("Bearer 8SbomlGg0EcXYB5wlzxZcZKgo-XbPnUggWBtZKX9EHzpP2ChsdasnNu0e4i2J3DaZEAu7f1NjWCNUCp4HkchQyQlWyHjaqJynJ2PTW_YdgdWvSgJ8AaVAxSYVxUvXnYx", forHTTPHeaderField: "Authorization")
        urlSession.dataTask(with: request) { (data, response, error) in
            DispatchQueue.main.async {
                guard let data = data else {
                    completionHandler(.failure(.noDataReceived))
                    return
                }
                
                guard let response = response as? HTTPURLResponse, (200...299) ~= response.statusCode else {
                    completionHandler(.failure(.badStatusCode))
                    
                    return
                }
                
                if let error = error {
                    let error = error as NSError
                    if error.domain == NSURLErrorDomain && error.code == NSURLErrorNotConnectedToInternet {
                        completionHandler(.failure(.noInternetConnection))
                        return
                    } else {
                        completionHandler(.failure(.other(rawError: error)))
                        return
                    }
                }
                completionHandler(.success(data))
            }
        }.resume()
    }
    
    // MARK: - Private Properties and Initializers
    
    private let urlSession = URLSession(configuration: URLSessionConfiguration.default)
    
    private init() {}
}
