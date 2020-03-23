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
        addDelegates()
    }
    private func addDelegates() {
        signUpView.emailTextField.delegate = self
        signUpView.passwordTextField.delegate = self
        signUpView.confirmPasswordTextField.delegate = self
    }
    
    @objc func validateFields() {
        guard signUpView.emailTextField.hasText, signUpView.passwordTextField.hasText, signUpView.confirmPasswordTextField.hasText else {
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
        signUpView.confirmPasswordTextField.addTarget(self, action: #selector(validateFields), for: .editingChanged)
    }
    
    @objc func signUpButton() {
        
     
            signUpFunction(email: signUpView.emailTextField.text, password: signUpView.passwordTextField.text, confirmPassword: signUpView.confirmPasswordTextField.text, displayName: signUpView.displayName.text)
        
    }
    
     private func checkEmailIsValid(email:String?) {
        guard let email = email else {
            hideWarningImage(warningImageView: signUpView.warningImageEmail)
            return
        }
        guard email != "" else {
    hideWarningImage(warningImageView: signUpView.warningImageEmail)
            return
        }
        email.isValidEmail ? animateCheckMark(warningImageView: signUpView.warningImageEmail) : animateWarning(warningImageView: signUpView.warningImageEmail)
    }
    
    private func checkPasswordIsValid(password:String?) {
        guard let password = password else {
hideWarningImage(warningImageView: signUpView.warningImagePassword)
            return
        }
        guard password != "" else {
hideWarningImage(warningImageView: signUpView.warningImagePassword)
            return
        }
        password.isValidPassword ? animateCheckMark(warningImageView: signUpView.warningImagePassword) : animateWarning(warningImageView: signUpView.warningImagePassword)
    }
    
    private func checkConfirmPasswordIsValid(confirmPassword:String?) {
        guard let confirmPassword = confirmPassword else {
            hideWarningImage(warningImageView: signUpView.warningImageConfirmPassword)
            return
        }
        guard confirmPassword != "" else {
            hideWarningImage(warningImageView: signUpView.warningImageConfirmPassword)
            return
        }
        
        confirmPassword == signUpView.passwordTextField.text ? animateCheckMark(warningImageView: signUpView.warningImageConfirmPassword) : animateWarning(warningImageView: signUpView.warningImageConfirmPassword)
        
    }
    private func hideWarningImage(warningImageView:UIImageView) {
        UIView.animate(withDuration: 0.3, animations: {
            warningImageView.alpha = 0.0
        }) { (bool) in
             warningImageView.isHidden = true
        }
       
    }
    private func animateCheckMark(warningImageView:UIImageView){
       warningImageView.isHidden = false
        UIView.transition(with: warningImageView, duration: 0.5, options: .transitionFlipFromRight, animations: {
            warningImageView.alpha = 1.0
             warningImageView.image = UIImage(systemName: "checkmark.circle")
        })
    }
    private func animateWarning(warningImageView:UIImageView){
         warningImageView.isHidden = false
        UIView.transition(with: warningImageView, duration: 0.5, options: .transitionFlipFromLeft, animations: {
            warningImageView.alpha = 1.0
            warningImageView.image = UIImage(systemName: "exclamationmark.triangle")
        })
    }
   
    private func signUpFunction(email:String?,password:String?,confirmPassword: String?, displayName:String?) {
        
        guard let email = email,
            let password = password,
            let confirmPassword = confirmPassword,
            let displayName = displayName
            
            else {
                
                return
        }
        
        guard email.isValidEmail else {
            self.showAlert(title: "Error", message: "Invalid Email")
            return
        }
        
        guard password.isValidPassword else {
            self.showAlert(title: "Error", message: "Invalid Password Format")

            return
        }
        
        guard confirmPassword == password else {
            self.showAlert(title: "Error", message: "Passwords Must Match")
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
                FirestoreService.manager.createAppUser(user: AppUser(from: user, coupleID: nil, preferences: [], eventsLiked: [])) { (result) in
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

extension SignUpVC:UITextFieldDelegate {
    func textFieldDidEndEditing(_ textField: UITextField) {
        switch textField.tag {
        case 0:
            checkEmailIsValid(email: textField.text)
        case 1:
            checkPasswordIsValid(password: textField.text)
        case 2:
            checkConfirmPasswordIsValid(confirmPassword: textField.text)
        default:
            print("")
        }
        print(textField.tag)
        
       
    }
}


