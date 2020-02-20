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
    
     func store(preference:[String]) {
        UserDefaults.standard.set(preference, forKey: preferences)
    }
    
    func getPreferences() -> [String]? {
        UserDefaults.standard.value(forKey: preferences) as? [String]
    }
    
    
}
