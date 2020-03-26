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
    var scrollView = UIScrollView(frame: UIScreen.main.bounds)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(scrollView)
        addObjcFunctionsToViewObjects()
        addDelegates()
        addKeyboardAppearObserver()
        addKeyboardDismissObserver()
        setScrollViewConstraints()
        setUpScrollView()
    }
    private func addDelegates() {
        signUpView.displayName.delegate = self
        signUpView.emailTextField.delegate = self
        signUpView.passwordTextField.delegate = self
        signUpView.confirmPasswordTextField.delegate = self
    }
    
    private func setScrollViewConstraints() {
        self.scrollView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.scrollView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            self.scrollView.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 20),
            self.scrollView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            self.scrollView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
        ])
    }
    
    private func setUpScrollView() {
        scrollView.addSubview(signUpView)
        scrollView.alwaysBounceVertical = false
        view.addSubview(scrollView)
    }
    
    private func addKeyboardAppearObserver()
    {
        NotificationCenter.default.addObserver(self, selector: #selector(handleKeyboardAppearing(sender:)), name: UIResponder.keyboardWillShowNotification,
                                               object: nil)
    }
    
    private func addKeyboardDismissObserver()
    {
        NotificationCenter.default.addObserver(self, selector: #selector(handleKeyboardDisappearing(sender:)), name: UIResponder.keyboardWillHideNotification,
                                               object: nil)
    }
    
    private func adjustInsetForKeyboardShow(_ show: Bool, notification: Notification) {
        guard
            let userInfo = notification.userInfo,
            let keyboardFrame = userInfo[UIResponder.keyboardFrameEndUserInfoKey]
                as? NSValue
            else {
                return
        }
        
        if notification.name == UIResponder.keyboardWillHideNotification{
            scrollView.setContentOffset(.zero, animated: true)
        } else {
            let scrollPoint = CGPoint(x: 0.0, y: self.signUpView.createButton.frame.origin.y - (keyboardFrame.cgRectValue.height) - view.frame.height * 0.05)
            
            scrollView.setContentOffset(scrollPoint, animated: true)
        }
        
        let adjustmentHeight = (keyboardFrame.cgRectValue.height + 20) * (show ? 3 : -3)
        scrollView.contentInset.bottom += adjustmentHeight
        scrollView.verticalScrollIndicatorInsets.bottom += adjustmentHeight
    }
    
    @objc func handleKeyboardAppearing(sender: Notification) {
        adjustInsetForKeyboardShow(true, notification: sender)
    }
    
    @objc func handleKeyboardDisappearing(sender: Notification) {
        adjustInsetForKeyboardShow(false, notification: sender)
        
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
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}


