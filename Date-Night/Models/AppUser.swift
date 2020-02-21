//
//  AppUser.swift
//  Date-Night
//
//  Created by Phoenix McKnight on 1/28/20.
//  Copyright © 2020 Michelle Cueva. All rights reserved.
//

import Foundation
import Firebase

struct AppUser {
    let email: String?
    let uid: String
    let userName: String?
    let photoURL: String?
    let sessionID: String?
    let preferences: [String]
    let partnerEmail: String?
    let partnerUserName: String?
    let isAdmin:Bool
    let eventsLiked: [String]
    let partnerEventsLiked: [String]
    
    init(from user: User,sessionID:String?, preferences:[String], eventsLiked: [String], partnerEventsLiked: [String]) {
        self.userName = user.displayName
        self.email = user.email
        self.uid = user.uid
        self.photoURL = user.photoURL?.absoluteString
        self.sessionID = sessionID
        self.preferences = preferences
        self.partnerEmail = nil
        self.partnerUserName = nil
        self.isAdmin = false
        self.eventsLiked = eventsLiked
        self.partnerEventsLiked = partnerEventsLiked
    }
    
    init?(from dict: [String: Any], id: String) {
        guard let userName = dict["userName"] as? String,
            let email = dict["email"] as? String,
            let photoURL = dict["photoURL"] as? String,
            let sessionID = dict["sessionID"] as? String,
            let preferences = dict["preferences"] as? [String],
            let partnerEmail = dict["partnerEmail"] as? String,
            let partnerUserName = dict["partnerUserName"] as? String,
            let isAdmin = dict["isAdmin"] as? Bool,
            let eventsLiked = dict["eventsLiked"] as? [String],
            let partnerEventsLiked = dict["partnerEventsLiked"] as? [String]
            else {return nil}
        
        self.userName = userName
        self.email = email
        self.uid = id
        self.photoURL = photoURL
        self.sessionID = sessionID
        self.preferences = preferences
        self.partnerEmail = partnerEmail
        self.partnerUserName = partnerUserName
        self.isAdmin = isAdmin
        self.eventsLiked = eventsLiked
        self.partnerEventsLiked = partnerEventsLiked
    }
    
    var fieldsDict: [String: Any] {
        return [
            "userName": self.userName ?? "",
            "email": self.email ?? "",
            "sessionID": self.sessionID ?? "",
            "preferences": self.preferences,
            "photoURL": self.photoURL ?? "",
            "partnerEmail": self.partnerEmail ?? "",
            "partnerUserName": self.partnerUserName ?? "",
            "uid": self.uid,
            "isAdmin":self.isAdmin,
            "eventsLiked": self.eventsLiked,
            "partnerEventsLiked": self.partnerEventsLiked
        ]
    }
}
