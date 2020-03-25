//
//  AccountSettingsVC.swift
//  Date-Night
//
//  Created by Krystal Campbell on 3/24/20.
//  Copyright © 2020 Date Night Roulette. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseFirestore

class AccountSettingsVC: UIViewController {
    
    let accSettings = AccountSettingsView()
    
    private var isListenerEnabled:Bool = false
    
    var profilePartnerUser:AppUser? {
        didSet {
            isListenerEnabled = true
        }
        
    }
    var currentUser:AppUser? = nil {
        didSet {
            print("profile setting vc received current User")
        }
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(accSettings)
        addObjcFunctions()
    }
    
    private func addObjcFunctions() {
        accSettings.displayNameButton.addTarget(self, action: #selector(changeDisplayName), for: .touchUpInside)
        accSettings.removePartnerButton.addTarget(self, action: #selector(removePartner), for: .touchUpInside)
        accSettings.helpButton.addTarget(self, action: #selector(getSupport), for: .touchUpInside)
        accSettings.notificationsButton.addTarget(self, action: #selector(toggleNotifications), for: .touchUpInside)
        accSettings.logoutButton.addTarget(self, action: #selector(logOut), for: .touchUpInside)
    }
    
    
    @objc private func changeDisplayName(){
          //  present(OBDisplayNameSetupVC(), animated: true, completion: nil)
    }
    
    @objc private func removePartner(){
        
        FirestoreService.manager.deleteMatchedEvents(coupleID: profilePartnerUser?.coupleID) { [weak self](result) in
            self?.handlePartnerRemoval(result: result)
        }
        FirestoreService.manager.removePartnerReferencesInUserCollection(uid: Auth.auth().currentUser?.uid, partnerUID: profilePartnerUser?.uid) { [weak self](result) in
            self?.handlePartnerRemoval(result: result)
        }
    }
    
    private func handlePartnerRemoval(result:Result<(),AppError>) {
        switch result {
        case .failure(let error):
            print(error)
        case .success():
            print("successfully removed partner reference")
        }
    }
    
    @objc private func getSupport(){}
    
    @objc private func toggleNotifications(){
     //present(OBNotifcationsVC(), animated: true, completion: nil)
    }
    
    @objc private func logOut(){
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



