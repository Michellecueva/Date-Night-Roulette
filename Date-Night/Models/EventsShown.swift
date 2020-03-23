//
//  EventsShown.swift
//  Date-Night
//
//  Created by Michelle Cueva on 3/23/20.
//  Copyright © 2020 Date Night Roulette. All rights reserved.
//

import Foundation

protocol EventsShown {
    var coupleID: String? {get}
    
    var title: String? {get}
    var eventID: String? {get }
    var address: String? {get }
    var description: String? {get}
    var imageURL: String? {get}
    var websiteURL: String? {get }
    var type: String? {get}
}

