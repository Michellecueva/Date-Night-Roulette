//
//  OBDisplayNameSetupVC.swift
//  Date-Night
//
//  Created by Krystal Campbell on 3/20/20.
//  Copyright © 2020 Date Night Roulette. All rights reserved.
//

import UIKit

class OBDisplayNameSetupVC: UIViewController {

    
     let obDisplayName = OBDisplayNameSetupView()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(obDisplayName)

    }

}
