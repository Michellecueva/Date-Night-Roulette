//
//  Sessions.swift
//  testAppCapstone
//
//  Created by Phoenix McKnight on 1/27/20.
//  Copyright © 2020 Phoenix McKnight. All rights reserved.
//

import Foundation


struct FBEvents: Codable {
    let title: String
    let address: String
    let eventID: String
    let description: String
    let imageURL: String?
    let websiteURL: String?
    
    init(title: String, address: String, eventID: String, description: String, imageURL: String, websiteURL: String) {
        self.title = title
        self.address = address
        self.eventID = eventID
        self.description = description
        self.imageURL = imageURL
        self.websiteURL = websiteURL
        
    }
    
    init? (from dict: [String: Any], id: String) {
    guard let title = dict["title"] as? String,
    let address = dict["address"] as? String,
        let eventID = dict["eventID"] as? String,
        let description = dict["description"] as? String,
        let imageURL = dict["imageURL"] as? String,
        let websiteURL = dict["websiteURL"] as? String else {
            return nil
        }
        
        self.title = title
        self.address = address
        self.eventID = eventID
        self.description = description
        self.imageURL = imageURL
        self.websiteURL = websiteURL
    }
    
    var fieldsDict: [String: Any] {
        return [
            "title": self.title,
            "address": self.address,
            "eventID": self.eventID,
            "description": self.description,
            "imageURL": self.imageURL ?? "Image Unavailable",
            "websiteURL": self.websiteURL ?? "Website URL Unavailable"
        ]
    }
    
}
