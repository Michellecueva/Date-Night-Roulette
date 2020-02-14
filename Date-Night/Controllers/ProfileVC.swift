//
//  ProfileVC.swift
//  Date-Night
//
//  Created by Phoenix McKnight on 2/10/20.
//  Copyright © 2020 Michelle Cueva. All rights reserved.
//

import UIKit

class ProfileSettingVC: UIViewController {

    var profileSetting = ProfileSettingView()



    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        view.addSubview(profileSetting)
    }
}
/*
    var user: AppUser!
    var isCurrentUser = false
​
​
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        view.addSubview(profileSetting)
    
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setUpUserName()
    }
    
​
    private func setUpUserName() {
        if let userName = FirebaseAuthService.manager.currentUser?.displayName {
            profileSetting.userNameLabel.text = "Hi \(userName) !"
        
        }
    
        
        
    }
}*/
