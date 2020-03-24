//
//  MatchedHistory.swift
//  Date-Night
//
//  Created by Krystal Campbell on 2/27/20.
//  Copyright © 2020 Date Night Roulette. All rights reserved.
//

import Foundation
import Firebase

struct MatchedEvent: Codable,Hashable, EventsShown {
    
    let coupleID: String?
    let title: String?
    let eventID: String?
    let address: String?
    let description: String?
    let imageURL: String?
    let websiteURL: String?
    let type:String
    
    var coupleId: String? {
        return coupleID
    }
    
    var heading: String? {
        return title
    }
    var eventId: String? {
        return eventID
    }
    var location: String? {
        return address
    }
    var summary: String? {
        return description
    }
    var imageUrl: String? {
        return imageURL
    }
    var websiteUrl: String? {
        return websiteURL
    }
    var category: String? {
        return type
    }

    
    init(coupleID: String, title: String, eventID: String, address: String?,description: String?, imageURL: String?, websiteURL: String?,type:String){
        self.coupleID = coupleID
        self.title = title
        self.eventID = eventID
        self.address = address
        self.description = description
        self.imageURL = imageURL
        self.websiteURL = websiteURL
        self.type = type
    }
    
    init?(from dict: [String: Any], id: String){
        guard let coupleID = dict["coupleID"] as? String,
            let title = dict["title"] as? String,
            let address = dict["address"] as? String,
            let eventID = dict["eventID"] as? String,
            let description = dict["description"] as? String,
            let imageURL = dict["imageURL"] as? String,
            let websiteURL = dict["websiteURL"] as? String,
            let type = dict["type"] as? String
            else {
                return nil
        }
        
        self.coupleID = coupleID
        self.title = title
        self.eventID = eventID
        self.address = address
        self.description = description
        self.imageURL = imageURL
        self.websiteURL = websiteURL
        self.type = type
    }
    var fieldsDict: [String: Any] {
        return [
            "coupleID": self.coupleID ?? "",
            "title": self.title ?? "",
            "eventID": self.eventID ?? "",
            "address": self.address ?? "",
            "description": self.description ?? "",
            "imageURL": self.imageURL ?? "Image Unavailable",
            "websiteURL": self.websiteURL ?? "Website URL Unavailable",
            "type":self.type
        ]
    }
}
