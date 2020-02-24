//
//  EventfulModel.swift
//  CapstoneDraft3
//
//  Created by Krystal Campbell on 2/18/20.
//  Copyright © 2020 Krystal Campbell. All rights reserved.
//

import Foundation

// MARK: - Welcome

enum JSONError: Error {
             case decodingError(Error)
         }

struct WelcomeWrapper: Codable {
    let events: EventWrapper?

}

// MARK: - Events
struct EventWrapper: Codable {
    let event: [Event]
}

// MARK: - Event
struct Event: Codable {
    let venue_url: String
    let description: String?
    let title: String?
    let image: Image?
    let venue_address: String
    let id:String
    let venue_name:String
    
   
    
        static func getEventfulData(data:Data)throws -> [Event]? {
            do{
                let eventData = try
                    JSONDecoder().decode(WelcomeWrapper.self, from: data)
                return eventData.events?.event
            } catch {
                print(error)
                return nil
            }
        }
}

// MARK: - Image
struct Image: Codable {
    let width: String
    let medium: Medium
    let url: String
    let height: String
}

// MARK: - Medium
struct Medium: Codable {
    let width: String
    let url: String
    let height: String
}
