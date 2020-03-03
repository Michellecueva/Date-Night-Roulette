//
//  MatchedHistory.swift
//  Date-Night
//
//  Created by Krystal Campbell on 2/27/20.
//  Copyright © 2020 Date Night Roulette. All rights reserved.
//

import Foundation
import Firebase

struct MatchedEvent: Codable,Hashable {
    
    let userOne: String?
    let userTwo: String?
    let title: String?
    let eventID: String?
    
    init(userOne: String, userTwo: String, title: String, eventID: String){
        self.userOne = userOne
        self.userTwo = userTwo
        self.title = title
        self.eventID = eventID
    }
    
    init?(from dict: [String: Any], id: String){
        guard let userOne = dict["userOne"] as? String,
        let userTwo = dict["userTwo"] as? String,
        let title = dict["title"] as? String,
        let eventID = dict["eventID"] as? String
            else {
                return nil
        }
        
        self.userOne = userOne
        self.userTwo = userTwo
        self.title = title
        self.eventID = eventID
    }
    var fieldsDict: [String: Any] {
        return [
            "userOne": self.userOne ?? "",
            "userTwo": self.userTwo ?? "",
            "title": self.title ?? "",
            "eventID": self.eventID ?? ""
        ]
    }
}
