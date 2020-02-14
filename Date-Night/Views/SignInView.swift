//
//  SignInView.swift
//  Date-Night
//
//  Created by Kimball Yang on 2/3/20.
//  Copyright © 2020 Michelle Cueva. All rights reserved.
//

import UIKit

class SignInView: UIView {
    
 //   MARK:- Properties
    
    lazy var titleLabel : UILabel = {
        let label = UILabel()
        label.textColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        label.text = "Date Night\nRoulette"
        label.numberOfLines = 0
        label.textAlignment = .center
        label.adjustsFontForContentSizeCategory = true
        label.font = UIFont(name: "CopperPlate", size: 50)
        return label
    }()
    
    lazy var emailField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Email Address"
        textField.borderStyle = .roundedRect
        textField.backgroundColor = #colorLiteral(red: 0.9164920449, green: 0.7743749022, blue: 0.9852260947, alpha: 1)
        return textField
    }()
    
    lazy var passwordField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Password"
        textField.borderStyle = .roundedRect
        textField.backgroundColor = #colorLiteral(red: 0.9164920449, green: 0.7743749022, blue: 0.9852260947, alpha: 1)
        textField.isSecureTextEntry = true
        return textField
    }()
    lazy var loginButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Login", for: .normal)
        button.setTitleColor(.blue, for: .normal)
        button.titleLabel?.font = UIFont(name: "Arial-Bold", size: 16)
        button.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        button.layer.cornerRadius = 5
        button.isEnabled = true
        return button
    }()
    
    lazy var createAccountButton: UIButton = {
        let button = UIButton(type: .system)
        let attributedTitle = NSMutableAttributedString(
            string: "Dont have an account?  ",
            attributes: [
                NSAttributedString.Key.font: UIFont(name: "Verdana", size: 14)!,
                NSAttributedString.Key.foregroundColor: UIColor.white
            ]
        )
        
        button.setTitleColor(UIColor.blue, for: .normal)
        attributedTitle.append(NSAttributedString(
            string: "Sign Up",
            attributes: [
                NSAttributedString.Key.font: UIFont(name: "Verdana", size: 14)!,
                NSAttributedString.Key.foregroundColor:  UIColor.blue
            ]
        ))
        
        button.setAttributedTitle(attributedTitle, for: .normal)
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: UIScreen.main.bounds)
        
        self.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        setSubviews()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: -UI Setup
    
    private func setSubviews() {
        self.addSubview(titleLabel)
        self.addSubview(emailField)
        self.addSubview(passwordField)
        self.addSubview(loginButton)
        self.addSubview(createAccountButton)
    }
    
    private func setConstraints() {
        setTitleLabelConstraints()
        setEmailFieldConstraints()
        setPasswordFieldConstraints()
        setLogInButtonConstraints()
        setCreateAccountButtonConstraints()
    }
    
    private func setTitleLabelConstraints() {
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 140),
            titleLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor)
        ])
    }
    
    private func setEmailFieldConstraints() {
        emailField.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            emailField.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 50),
            emailField.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            emailField.widthAnchor.constraint(equalToConstant: 300),
            emailField.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
    
    private func setPasswordFieldConstraints() {
        passwordField.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            passwordField.topAnchor.constraint(equalTo: emailField.bottomAnchor, constant: 30),
            passwordField.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            passwordField.widthAnchor.constraint(equalToConstant: 300),
            passwordField.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
    
    private func setLogInButtonConstraints() {
        loginButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            loginButton.topAnchor.constraint(equalTo: passwordField.bottomAnchor, constant: 30),
            loginButton.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            loginButton.widthAnchor.constraint(equalToConstant: 300),
            loginButton.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
    
    private func setCreateAccountButtonConstraints() {
        createAccountButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            createAccountButton.topAnchor.constraint(equalTo: loginButton.bottomAnchor, constant: 30),
            createAccountButton.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            createAccountButton.widthAnchor.constraint(equalToConstant: 300),
            createAccountButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
}
