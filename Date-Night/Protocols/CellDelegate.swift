//
//  CellDelegate.swift
//  Date-Night
//
//  Created by Michelle Cueva on 2/9/20.
//  Copyright © 2020 Michelle Cueva. All rights reserved.
//

import Foundation

protocol CellDelegate: AnyObject {
    func handleAcceptedInvite(tag: Int)
    func handleDeclinedInvite(tag: Int)
}
