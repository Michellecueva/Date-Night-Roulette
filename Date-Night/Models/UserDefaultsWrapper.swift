//
//  UserDefaultsWrapper.swift
//  Date-Night
//
//  Created by Phoenix McKnight on 2/18/20.
//  Copyright © 2020 Michelle Cueva. All rights reserved.
//

import Foundation

class UserDefaultsWrapper {
    
    static let standard = UserDefaultsWrapper()
    
    private let preferences = "preferences"
    
    private let eventsLiked = "eventsLiked"
    
     func store(preference:[String]) {
        UserDefaults.standard.set(preference, forKey: preferences)
    }
    
    func getPreferences() -> [String]? {
        UserDefaults.standard.value(forKey: preferences) as? [String]
    }
    
    func store(eventsLikedArr: [String]) {
        UserDefaults.standard.set(eventsLikedArr, forKey: eventsLiked)
    }
    
    func getEventsLiked() -> [String]? {
        UserDefaults.standard.value(forKey: eventsLiked) as? [String]
    }
    
}
