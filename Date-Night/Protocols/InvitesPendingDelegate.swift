//
//  InvitesPendingDelegate.swift
//  Date-Night
//
//  Created by Phoenix McKnight on 2/13/20.
//  Copyright © 2020 Michelle Cueva. All rights reserved.
//

import Foundation

protocol InvitesPendingDelegate:AnyObject {
    func  changeStatus(status: HomePageStatus)
}
