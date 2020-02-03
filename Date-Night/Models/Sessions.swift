//
//  Sessions.swift
//  testAppCapstone
//
//  Created by Phoenix McKnight on 1/27/20.
//  Copyright © 2020 Phoenix McKnight. All rights reserved.
//

import Foundation


struct Session: Codable {
    let userOne: String
    let userTwo: String
    let eventID: String
    let eventList: [String]
    let userOneResponse: Bool
    let userTwoResponse: Bool
    
    init(userOne: String, userTwo: String, eventID: String, eventList: [String], userOneResponse: Bool, userTwoResponse: Bool) {
        self.userOne = userOne
        self.userTwo = userTwo
        self.eventID = eventID
        self.eventList = eventList
        self.userOneResponse = userOneResponse
        self.userTwoResponse = userTwoResponse
        
    }
    
    init? (from dict: [String: Any], id: String) {
    guard let userOne = dict["userOne"] as? String,
    let userTwo = dict["userTwo"] as? String,
        let eventID = dict["eventID"] as? String,
        let eventList = dict["eventList"] as? [String],
        let userOneResponse = dict["userOneResponse"] as? Bool,
        let userTwoResponse = dict["userTwoResponse"] as? Bool else {
            return nil
        }
        
        self.userOne = userOne
        self.userTwo = userTwo
        self.eventID = eventID
        self.eventList = eventList
        self.userOneResponse = userOneResponse
        self.userTwoResponse = userTwoResponse
    }
    
    var fieldsDict: [String: Any] {
        return [
            "userOne": self.userOne,
            "userTwo": self.userTwo,
            "eventID": self.eventID,
            "eventList": self.eventList,
            "userOneResponse": self.userOneResponse,
            "userTwoResponse": self.userTwoResponse
        ]
    }
    
}
