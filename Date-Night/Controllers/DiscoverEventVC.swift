//
//  DiscoverEventVC.swift
//  Date-Night
//
//  Created by Kimball Yang on 2/6/20.
//  Copyright © 2020 Michelle Cueva. All rights reserved.
//

import UIKit

class DiscoverEventVC: UIViewController {

    var discover = DiscoverEventView()
    
    //add button 
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        view.addSubview(discover)
    }


}
