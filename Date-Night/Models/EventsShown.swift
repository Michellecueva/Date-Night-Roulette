//
//  EventsShown.swift
//  Date-Night
//
//  Created by Michelle Cueva on 3/23/20.
//  Copyright © 2020 Date Night Roulette. All rights reserved.
//

import Foundation

protocol EventsShown {
    var coupleId: String? {get}
    
    var heading: String? {get}
    var eventId: String? {get }
    var location: String? {get }
    var summary: String? {get}
    var imageUrl: String? {get}
    var websiteUrl: String? {get }
    var category: String? {get}
}

