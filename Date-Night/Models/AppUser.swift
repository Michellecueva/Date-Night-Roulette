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
    let dateCreated: Date?
    let photoURL: String?
    let sessionID: String?
    let preferences: [String]
    
    init(from user: User,sessionID:String, preferences:[String]) {
        self.userName = user.displayName
        self.email = user.email
        self.uid = user.uid
        self.dateCreated = user.metadata.creationDate
        self.photoURL = user.photoURL?.absoluteString
        self.sessionID = sessionID
        self.preferences = preferences
        
    }
    
    init?(from dict: [String: Any], id: String) {
        guard let userName = dict["userName"] as? String,
            let email = dict["email"] as? String,
            let photoURL = dict["photoURL"] as? String,
            let sessionID = dict["sessionID"] as? String,
            let preferences = dict["preferences"] as? [String],
            let dateCreated = (dict["dateCreated"] as? Timestamp)?.dateValue()
            else {return nil}
        
        self.userName = userName
        self.email = email
        self.uid = id
        self.dateCreated = dateCreated
        self.photoURL = photoURL
        self.sessionID = sessionID
        self.preferences = preferences
    }
    
    var fieldsDict: [String: Any] {
        return [
            "userName": self.userName ?? "",
            "email": self.email ?? "",
            "sessionID": self.sessionID ?? "",
            "preferences": self.preferences,
            "photoURL": self.photoURL ?? ""
        ]
    }
}
