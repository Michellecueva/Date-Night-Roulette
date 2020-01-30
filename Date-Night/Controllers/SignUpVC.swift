//
//  SignUpVC.swift
//  Date-Night
//
//  Created by Michelle Cueva on 1/27/20.
//  Copyright © 2020 Michelle Cueva. All rights reserved.
//

import UIKit
import FirebaseAuth

class SignUpVC: UIViewController {
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loginButtonFunctions(email: "Michelle2@gmail.com", password: "password1234!", firstName: "Michelle")
        
        // Do any additional setup after loading the view.
    }
    
    func loginButtonFunctions(email:String?,password:String?,firstName:String?) {
        
        guard let email = email,
            let password = password,
            let firstName = firstName else {
                
                return
        }
        
        
        guard  email.isValidEmail else {
            
            return
        }
        
        
        
        guard password.isValidPassword else {
            return
        }
        FirebaseAuthService.manager.createNewUser(email: email, password: password) { (result) in
            
            
            self.updateUserAccount(with: result, firstName: firstName)
        }
        
        
        
        
    }
    
    
    
    private func updateUserAccount(with result: Result<User,AppError>,firstName:String) {
        
        DispatchQueue.main.async {
            switch result {
            case .failure(let error):
                print(error)
                
            case.success(let user):
                FirestoreService.manager.createAppUser(user: AppUser(from: user, sessionID: nil, preferences: [])) { (result) in
                    FirestoreService.manager.updateCurrentUser(firstName: firstName, photoURL: nil) { (result) in
                        switch result {
                        case .failure(let error):
                            print(error)
                            
                        case .success():
                            FirebaseAuthService.manager.updateUserFields(name: firstName, photoURL: nil) { (result) in
                                switch result {
                                case .failure(let error):
                                    print(error)
                                    
                                case .success():
                                    print("created user")
                                }
                            }
                        }
                    }
                }
            }
        }
    }
}

private func updateUserFields(result:Result<User,AppError>,firstName:String) {
    
    FirebaseAuthService.manager.updateUserFields(name: firstName , photoURL: nil) { (result) in
        switch result {
        case .failure(let error):
            print(error)
            
        case .success():
            handleLoginResponse(vc: UIViewController(), with: result)
            
        }
    }
    
}
private func handleLoginResponse(vc viewController:UIViewController,with result: Result<(), Error>) {
    switch result {
        
    case .success:
        guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
            let sceneDelegate = windowScene.delegate as? SceneDelegate, let window = sceneDelegate.window
            else {
                return
        }
        
        UIView.transition(with: window, duration: 0.3, options: .transitionFlipFromBottom, animations: {
            if FirebaseAuthService.manager.currentUser != nil {
                window.rootViewController = viewController
                
            } else {
                print("No current user")
            }
        }, completion: nil)
    case .failure(let error):
        print(error)
    }
}

/*
 // MARK: - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
 // Get the new view controller using segue.destination.
 // Pass the selected object to the new view controller.
 }
 */


