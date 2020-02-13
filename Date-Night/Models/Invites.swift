//
//  Invites.swift
//  testAppCapstone
//
//  Created by Phoenix McKnight on 1/27/20.
//  Copyright © 2020 Phoenix McKnight. All rights reserved.
//

import Foundation

enum invitationStatus: String {
   
    case pending
    case accepted
    case declined
    
}

struct Invites:Codable,Hashable {
    let id: String
    let from:String
    let to:String
    let invitationStatus:String
    
    init(from:String, to:String, invitationStatus:invitationStatus) {
        self.id = UUID().description
        self.from = from
        self.to = to
        self.invitationStatus = invitationStatus.rawValue
    }
    
    init?(from dict: [String:Any], id:String) {
        guard let from = dict["from"] as? String, let to = dict["to"] as? String, let invitationStatus = dict["invitationStatus"] as? String else { return nil}
        self.id = id
        self.from = from
        self.to = to
        self.invitationStatus = invitationStatus
    }
    
    var fieldsDictionary:[String:Any] {
        return ["from":self.from,"to":self.to,"invitationStatus":invitationStatus]
    }
}

