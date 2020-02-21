

import Foundation


struct FBEvents: Codable {
    let title: String?
    let address: String?
    let eventID: String
    let description: String?
    let imageURL: String?
    let websiteURL: String?
    let type:String
    
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
