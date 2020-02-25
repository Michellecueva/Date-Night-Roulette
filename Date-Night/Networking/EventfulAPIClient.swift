//
//  SeatGeekAPIClient.swift
//  CapstoneDraft2
//
//  Created by Krystal Campbell on 1/30/20.
//  Copyright © 2020 Krystal Campbell. All rights reserved.
//

import Foundation


struct EventfulAPIClient{
    private init() {}
    static let shared = EventfulAPIClient()
    
    //change function to get events for categories
    
    func getEventsFrom(category: String, completionHandler: @escaping (Result <[Event], AppError>) ->()){
        let urlStr = "http://api.eventful.com/json/events/search?...&keywords=\(category)&location=New+York+City&date=future&app_key=\(Secrets.eventKey)&page_size=2"
        guard let url = URL(string: urlStr) else {
            print(urlStr)
            completionHandler(.failure(AppError.badURL))
            return
        }
        NetworkHelper.manager.performDataTask(withUrl: url, andMethod: .get) { (result) in
            switch result {
            case .failure(let error):
                print(url)
                completionHandler(.failure(.other(rawError: error)))
            case .success(let data):
                do{
                    print(url)
                 let eventArray = try Event.getEventfulData(data: data)
                completionHandler(.success(eventArray ?? []))
                } catch {
                completionHandler(.failure(AppError.couldNotParseJSON(rawError: error)))
                }
            }
        }
    }
}

