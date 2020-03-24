//
//  OBNotifcationsVC.swift
//  Date-Night
//
//  Created by Krystal Campbell on 3/20/20.
//  Copyright © 2020 Date Night Roulette. All rights reserved.
//

import UIKit

class OBNotifcationsVC: UIViewController {
    
    
  let obNotifications = OBNotificationsView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(obNotifications)
        // Do any additional setup after loading the view.
    }
    

  
}
