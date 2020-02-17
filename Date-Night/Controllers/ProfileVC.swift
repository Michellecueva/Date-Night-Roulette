//
//  ProfileVC.swift
//  Date-Night
//
//  Created by Phoenix McKnight on 2/10/20.
//  Copyright © 2020 Michelle Cueva. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseFirestore


class ProfileSettingVC: UIViewController {
    
    var profileSetting = ProfileSettingView()
    
    var isCurrentUser = false
  
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        view.addSubview(profileSetting)
        logOut()
        print(FirebaseAuthService.manager.currentUser?.email)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setUpUserName()
        setUpPartnerEmailDisplay(userID: FirebaseAuthService.manager.currentUser?.uid ?? "" )
    }
    
    private func setUpUserName() {
        if let userName = FirebaseAuthService.manager.currentUser?.displayName {
            profileSetting.userNameLabel.text = "Hi \(userName) !"
            
        }
    }
    
    private func setUpPartnerEmailDisplay(userID: String){
        FirestoreService.manager.getUser(userID: userID) { (result) in
            switch result {
            case .success(let user):
                self.profileSetting.partnerEmailDisplayLabel.text = user.partnerEmail
                print("succesfully added partner email\(user.partnerEmail)")
            case .failure(let error):
                print(error)
            }
        }
    }
    
    
    
    private func logOut(){
        profileSetting.logoutButton.addTarget(self, action: #selector(signOut), for:.touchUpInside )
    }
    
    @objc private func signOut(){
        FirebaseAuthService.manager.signOut { [weak self](result) in
            self?.handleSignOut(vc: SignInVC(), with: result)
        }
        
    }
    private func handleSignOut(vc
        viewController:UIViewController,with result: Result<(), AppError>) {
        switch result {
            
        case .success:
            guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
                let sceneDelegate = windowScene.delegate as? SceneDelegate, let window = sceneDelegate.window
                else {
                    return
            }
            
            UIView.transition(with: window, duration: 0.3, options: .transitionFlipFromBottom, animations: {
                if FirebaseAuthService.manager.currentUser == nil {
                    window.rootViewController = viewController
                    
                } else {
                    
                    print("No current user")
                }
            }, completion: nil)
        case .failure(let error):
            print(error)
        }
    }
}


