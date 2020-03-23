

import Foundation


struct FBEvents: Codable, EventsShown {
    
    let title: String?
    let address: String?
    let eventID: String
    let description: String?
    let imageURL: String?
    let websiteURL: String?
    let type:String
    
    var coupleId: String?
    
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
    
    init(title: String?, address: String?, eventID: String, description: String?, imageURL: String?, websiteURL: String?,type:String) {
        self.title = title
        self.address = address
        self.eventID = eventID
        self.description = description
        self.imageURL = imageURL
        self.websiteURL = websiteURL
        self.type = type
    }
    
    init? (from dict: [String: Any], id: String) {
        guard let title = dict["title"] as? String,
            let address = dict["address"] as? String,
            let eventID = dict["eventID"] as? String,
            let description = dict["description"] as? String,
            let imageURL = dict["imageURL"] as? String,
            let websiteURL = dict["websiteURL"] as? String,
            let type = dict["type"] as? String
            else {
                return nil
        }
        
        self.title = title
        self.address = address
        self.eventID = eventID
        self.description = description
        self.imageURL = imageURL
        self.websiteURL = websiteURL
        self.type = type
    }
    
    var fieldsDict: [String: Any] {
        return [
            "title": self.title ?? "",
            "address": self.address ?? "",
            "eventID": self.eventID,
            "description": self.description ?? "",
            "imageURL": self.imageURL ?? "Image Unavailable",
            "websiteURL": self.websiteURL ?? "Website URL Unavailable",
            "type":self.type
        ]
    }
    
}
