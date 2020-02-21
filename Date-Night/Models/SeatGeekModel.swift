//
//  SeatGeekModel.swift
//  CapstoneDraft2
//
//  Created by Krystal Campbell on 1/30/20.
//  Copyright © 2020 Krystal Campbell. All rights reserved.
//

import Foundation

// MARK: - Welcome
struct Welcome: Codable {
    let meta: Meta
    let events: [Event]
}

// MARK: - Meta
struct Meta: Codable {
    let geolocation: Geolocation
}

// MARK: - Geolocation
struct Geolocation: Codable {
    let city, displayName: String
    let country: String
    let lon: Double
    let range: String
    let state: String
    let postalCode: String
    let lat: Double

    enum CodingKeys: String, CodingKey {
        case city
        case displayName = "display_name"
        case country, lon, range
        case state
        case postalCode = "postal_code"
        case lat
    }
}


// MARK: - Event
struct Event: Codable {
 
    let id: Int
    let title: String?  
    let type: String?
    let eventDescription, datetimeLocal, visibleUntilUTC: String?
    let performers: [Performer]
    let url: String?
    let venue: Venue
    let shortTitle, datetimeUTC: String?
    
    enum JSONError: Error {
           case decodingError(Error)
       }
    
    static func getSeatGeekData(data:Data)throws -> [Event]? {
        do{
            let catData = try
                JSONDecoder().decode(Welcome.self, from: data)
            return catData.events
        } catch {
            print(error)
            return nil
        }
    }

    
}

// MARK: - Performer
struct Performer: Codable {
    let image: String?
    let images: Images
    let id: Int?
    let name: String?
    let url: String?
    let imageAttribution: String?
}

// MARK: - Images
struct Images: Codable {
    let huge: String?
}

// MARK: - Venue
struct Venue: Codable {
    let postalCode: String?
    let id: Int?
    let city: String?
    let extendedAddress: String?
    let state: String?
    let location: Location
    let address: String?
    let name: String?
    let url: String?
    let country: String?

}

// MARK: - Location
struct Location: Codable {
    let lat, lon: Double?
}


