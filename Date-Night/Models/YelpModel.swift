//
//  YelpModel.swift
//  CapstoneDraft1
//
//  Created by Krystal Campbell on 3/17/20.
//  Copyright © 2020 Krystal Campbell. All rights reserved.
//

import Foundation

// MARK: - Welcome
struct Welcome: Codable {
    let businesses: [Business]?
}

// MARK: - Business
struct Business: Codable {
    let id, name: String
    let imageURL: String
    let isClosed: Bool?
    let url: String?
    let categories: [Category]
    let coordinates: Coordinates
    let location: Location
    let displayPhone: String?


    enum CodingKeys: String, CodingKey {
        case id, name
        case imageURL = "image_url"
        case isClosed = "is_closed"
        case url
        case categories, coordinates, location
        case displayPhone = "display_phone"
    }
    
     enum JSONError: Error {
               case decodingError(Error)
           }
    
        static func getYelpData(data:Data)throws -> [Business]? {
            do{
                let yelpData = try
                    JSONDecoder().decode(Welcome.self, from: data)
                return yelpData.businesses as! [Business]?
            } catch {
                print(error)
                return nil
            }
        }
}

// MARK: - Category
struct Category: Codable {
    let title: String
}

// MARK: - Center
struct Coordinates: Codable {
    let latitude, longitude: Double
}

// MARK: - Location
struct Location: Codable {
    let address1: String
    let address2: String?
    let city: String
    let zipCode: String
    let state: String
    let displayAddress: [String]

    enum CodingKeys: String, CodingKey {
        case address1, address2, city
        case zipCode = "zip_code"
        case state
        case displayAddress = "display_address"
    }
}


