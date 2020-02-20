//
//  SeatGeekAPIClient.swift
//  CapstoneDraft2
//
//  Created by Krystal Campbell on 1/30/20.
//  Copyright © 2020 Krystal Campbell. All rights reserved.
//

import Foundation


struct SeatGeekAPIClient{
    private init() {}
    static let shared = SeatGeekAPIClient()
    
    
    func getEventsFrom(category: String, completionHandler: @escaping (Result <[Event], AppError>) ->()){
        let urlStr = "https://api.seatgeek.com/2/events?type=\(category)&geoip=true&client_id=\(Secrets.seatKey)&per_page=2"
        
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
                    let catArray = try Event.getSeatGeekData(data: data)
                    completionHandler(.success(catArray ?? []))
                    
                } catch {
                    completionHandler(.failure(AppError.couldNotParseJSON(rawError: error)))
                }
            }
        }
    }
}
        
