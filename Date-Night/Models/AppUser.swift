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
    let firstName: String?
  //  let dateCreated: Date?
    let photoURL: String?
    let sessionID: String?
    let preferences: [String]
    let partnerEmail: String?
    let partnerUserName: String?
    
    init(from user: User,sessionID:String?, preferences:[String]) {
        self.firstName = user.displayName
        self.email = user.email
        self.uid = user.uid
      //  self.dateCreated = user.metadata.creationDate
        self.photoURL = user.photoURL?.absoluteString
        self.sessionID = sessionID
        self.preferences = preferences
        self.partnerEmail = nil
        self.partnerUserName = nil
    }
    
    init?(from dict: [String: Any], id: String) {
        guard let firstName = dict["firstName"] as? String,
            let email = dict["email"] as? String,
            let photoURL = dict["photoURL"] as? String,
            let sessionID = dict["sessionID"] as? String,
            let preferences = dict["preferences"] as? [String],
            let partnerEmail = dict["partnerEmail"] as? String,
            let partnerUserName = dict["partnerUserName"] as? String
            else {return nil}
        
        self.firstName = firstName
        self.email = email
        self.uid = id
      //  self.dateCreated = dateCreated
        self.photoURL = photoURL
        self.sessionID = sessionID
        self.preferences = preferences
        self.partnerEmail = partnerEmail
        self.partnerUserName = partnerUserName
    }
    
    var fieldsDict: [String: Any] {
        return [
            "firstName": self.firstName ?? "",
            "email": self.email ?? "",
            "sessionID": self.sessionID ?? "",
            "preferences": self.preferences,
            "photoURL": self.photoURL ?? "",
            "partnerEmail": self.partnerEmail ?? "",
            "partnerUserName": self.partnerUserName ?? "",
            "uid": self.uid
        ]
    }
}
