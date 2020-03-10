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
    
    let coupleID: String?
    let title: String?
    let eventID: String?
    
    init(coupleID: String, title: String, eventID: String){
        self.coupleID = coupleID
        self.title = title
        self.eventID = eventID
    }
    
    init?(from dict: [String: Any], id: String){
        guard let coupleID = dict["coupleID"] as? String,
        let title = dict["title"] as? String,
        let eventID = dict["eventID"] as? String
            else {
                return nil
        }
        
        self.coupleID = coupleID
        self.title = title
        self.eventID = eventID
    }
    var fieldsDict: [String: Any] {
        return [
            "coupleID": self.coupleID ?? "",
            "title": self.title ?? "",
            "eventID": self.eventID ?? ""
        ]
    }
}
