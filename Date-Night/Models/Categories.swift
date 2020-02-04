//
//  Categories.swift
//  CapstoneDraft2
//
//  Created by Krystal Campbell on 1/30/20.
//  Copyright © 2020 Krystal Campbell. All rights reserved.
//

import Foundation

struct Wrapper: Codable {
    let Categories: [Categories]
}

struct Categories: Codable {
    var data: CatWrapper
}

struct CatWrapper: Codable{
    
    let type: String
   
    enum JSONError: Error {
        case decodingError(Error)
    }
    
    
    static func getCategories() -> [Categories] {
        guard let fileName = Bundle.main.path(forResource: "Categories", ofType: "json")
            else {fatalError()}
        let fileURL = URL(fileURLWithPath: fileName)
        do {
            let data = try Data(contentsOf: fileURL)
            let cats = try
                JSONDecoder().decode(Wrapper.self, from: data)
            return cats.Categories
            
        } catch {
            fatalError("\(error)")
        }
    }
    
}
