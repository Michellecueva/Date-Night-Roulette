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
    let coupleID: String?
    let preferences: [String]
    let partnerEmail: String?
    let partnerUserName: String?
    let isAdmin:Bool
    let hasMatched: Bool
    let eventsLiked: [String]
    
    init(from user: User,coupleID:String?, preferences:[String], eventsLiked: [String]) {
        self.userName = user.displayName
        self.email = user.email
        self.uid = user.uid
        self.photoURL = user.photoURL?.absoluteString
        self.coupleID = coupleID
        self.preferences = preferences
        self.partnerEmail = nil
        self.partnerUserName = nil
        self.isAdmin = false
        self.eventsLiked = eventsLiked
        self.hasMatched = false
    }
    
    init?(from dict: [String: Any], id: String) {
        guard let userName = dict["userName"] as? String,
            let email = dict["email"] as? String,
            let photoURL = dict["photoURL"] as? String,
            let coupleID = dict["coupleID"] as? String,
            let preferences = dict["preferences"] as? [String],
            let partnerEmail = dict["partnerEmail"] as? String,
            let partnerUserName = dict["partnerUserName"] as? String,
            let isAdmin = dict["isAdmin"] as? Bool,
            let eventsLiked = dict["eventsLiked"] as? [String],
            let hasMatched = dict["hasMatched"] as? Bool
            else {return nil}
        
        self.userName = userName
        self.email = email
        self.uid = id
        self.photoURL = photoURL
        self.coupleID = coupleID
        self.preferences = preferences
        self.partnerEmail = partnerEmail
        self.partnerUserName = partnerUserName
        self.isAdmin = isAdmin
        self.eventsLiked = eventsLiked
        self.hasMatched = hasMatched
    }
    
    var fieldsDict: [String: Any] {
        return [
            "userName": self.userName ?? "",
            "email": self.email ?? "",
            "coupleID": self.coupleID ?? "",
            "preferences": self.preferences,
            "photoURL": self.photoURL ?? "",
            "partnerEmail": self.partnerEmail ?? "",
            "partnerUserName": self.partnerUserName ?? "",
            "uid": self.uid,
            "isAdmin":self.isAdmin,
            "eventsLiked": self.eventsLiked,
            "hasMatched": self.hasMatched
        ]
    }
}
