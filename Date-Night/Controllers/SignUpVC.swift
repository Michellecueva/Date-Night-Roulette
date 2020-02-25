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
    
    let signUpView = SignUpView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(signUpView)
        addObjcFunctionsToViewObjects()
    }
    
    @objc func validateFields() {
           guard signUpView.emailTextField.hasText, signUpView.passwordTextField.hasText else {
               signUpView.createButton.isEnabled = false
               return
           }
           signUpView.createButton.isEnabled = true
           signUpView.createButton.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
       }
    
   @objc private func addObjcFunctionsToViewObjects() {
    signUpView.createButton.addTarget(self, action: #selector(signUpButton), for: .touchUpInside)
    signUpView.emailTextField.addTarget(self, action: #selector(validateFields), for: .editingChanged)
    signUpView.passwordTextField.addTarget(self, action: #selector(validateFields), for: .editingChanged)
    }
    
    @objc func signUpButton() {
        signUpFunction(email: signUpView.emailTextField.text, password: signUpView.passwordTextField.text, displayName: signUpView.displayName.text)
    }
    
   private func signUpFunction(email:String?,password:String?,displayName:String?) {
        
        guard let email = email,
            let password = password,
            let displayName = displayName else {
                
                return
        }
    
        guard  email.isValidEmail else {
            
            return
        }
   
        guard password.isValidPassword else {
            return
        }
    FirebaseAuthService.manager.createNewUser(email: email.lowercased(), password: password) { (result) in
         
            self.updateUserAccount(with: result, displayName: displayName)
        }
    }
 
    private func updateUserAccount(with result: Result<User,AppError>,displayName:String) {
        
        DispatchQueue.main.async {
            switch result {
            case .failure(let error):
                print(error)
                
            case.success(let user):
                FirestoreService.manager.createAppUser(user: AppUser(from: user, sessionID: nil, preferences: [], eventsLiked: [])) { (result) in
                    FirestoreService.manager.updateCurrentUser(userName: displayName, photoURL: nil) { (result) in
                        switch result {
                        case .failure(let error):
                            print(error)
                            
                        case .success():
                            FirebaseAuthService.manager.updateUserFields(name: displayName, photoURL: nil) { (result) in
                                switch result {
                                case .failure(let error):
                                    print(error)
                                    
                                case .success():
                                    print("created user")
                                    handleLoginResponse(vc: UINavigationController(rootViewController:RootViewController()), with: result)
                                }
                            }
                        }
                    }
                }
            }
        }
    }
}

private func updateUserFields(result:Result<User,AppError>,displayName:String) {
    
    FirebaseAuthService.manager.updateUserFields(name: displayName , photoURL: nil) { (result) in
        switch result {
        case .failure(let error):
            print(error)
            
        case .success():
            handleLoginResponse(vc: UINavigationController(rootViewController: RootViewController()), with: result)
        }
    }
}

private func handleLoginResponse(vc
    viewController:UINavigationController,with result: Result<(), Error>) {
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




