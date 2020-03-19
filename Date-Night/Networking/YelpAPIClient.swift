//
//  DiscoveryAPIClient.swift
//  iOS-CTA-KCampbell
//
//  Created by Krystal Campbell on 12/2/19.
//  Copyright © 2019 Krystal Campbell. All rights reserved.
//

import Foundation

struct YelpAPIClient{
    private init() {}
    static let shared = YelpAPIClient()
    
    func getEventsFrom(category: String, completionHandler: @escaping (Result <[Business], AppError>) ->()){
        let urlStr = "https://api.yelp.com/v3/businesses/search?term=\(category)&location=nyc"
        
            guard let url = URL(string: urlStr) else {
                completionHandler(.failure(AppError.badURL))
                return
        }
        NetworkHelper.manager.performDataTask(withUrl: url, andMethod: .get) { (result) in
            switch result {
            case .failure(let error):
                completionHandler(.failure(.other(rawError: error)))
            case .success(let data):
                do{
                    let businessArr = try Business.getYelpData(data: data)
                    completionHandler(.success(businessArr ?? []))
                } catch {
                    completionHandler(.failure(AppError.couldNotParseJSON(rawError: error)))
                }
            }
        }
    }
}

