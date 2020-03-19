//
//  SignUpView.swift
//  Date-Night
//
//  Created by Kimball Yang on 2/3/20.
//  Copyright © 2020 Michelle Cueva. All rights reserved.
//

import UIKit

class SignUpView: UIView {
    
    //   MARK:- Properties
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = StyleGuide.AppColors.accentColor
        label.text = "Date Night\nRoulette"
        label.numberOfLines = 0
        label.textAlignment = .center
        label.adjustsFontForContentSizeCategory = true
        label.font = UIFont(name: StyleGuide.TitleFontStyle.fontName, size: StyleGuide.TitleFontStyle.fontSize)
        return label
    }()
    
    lazy var displayName: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Display Name"
        textField.font = UIFont(name: StyleGuide.TextFieldStyle.fontName, size: StyleGuide.TextFieldStyle.fontSize)
        textField.backgroundColor = .lightText
        textField.backgroundColor = StyleGuide.TextFieldStyle.backgroundColor
        textField.borderStyle = .roundedRect
        textField.autocorrectionType = .no
        return textField
    }()
    
    lazy var emailTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Enter Email"
        textField.font = UIFont(name: StyleGuide.TextFieldStyle.fontName, size: StyleGuide.TextFieldStyle.fontSize)
        textField.backgroundColor = .lightText
        textField.backgroundColor = StyleGuide.TextFieldStyle.backgroundColor
        textField.borderStyle = .roundedRect
        textField.autocorrectionType = .no
        return textField
    }()
    
    lazy var passwordTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Enter Password"
        textField.font = UIFont(name: StyleGuide.TextFieldStyle.fontName, size: StyleGuide.TextFieldStyle.fontSize)
        textField.backgroundColor = .lightText
        textField.backgroundColor = StyleGuide.TextFieldStyle.backgroundColor
        textField.borderStyle = .roundedRect
        textField.autocorrectionType = .no
        textField.isSecureTextEntry = true
        return textField
    }()
    
    lazy var confirmPasswordTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Confirm Password"
        textField.font = UIFont(name: StyleGuide.TextFieldStyle.fontName, size: StyleGuide.TextFieldStyle.fontSize)
        textField.backgroundColor = .lightText
        textField.backgroundColor = StyleGuide.TextFieldStyle.backgroundColor
        textField.borderStyle = .roundedRect
        textField.autocorrectionType = .no
        textField.isSecureTextEntry = true
        return textField
    }()
    
    
    lazy var createButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Create Account", for: .normal)
        button.setTitleColor(StyleGuide.ButtonStyle.fontColor, for: .normal)
        button.setTitleColor(StyleGuide.ButtonStyle.disabledColor, for: .disabled)
        button.titleLabel?.font = UIFont(name: "Helvetica-Neue", size: 14)
        button.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        button.layer.cornerRadius = StyleGuide.ButtonStyle.cornerRadius
        button.isEnabled = false
        return button
    }()
    
    lazy var stackView: UIStackView = {
        let stackView = UIStackView(
            arrangedSubviews: [
                displayName,
                emailTextField,
                passwordTextField,
                confirmPasswordTextField
            ]
        )
        
        stackView.axis = .vertical
        stackView.spacing = 25
        stackView.distribution = .fillEqually
        return stackView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: UIScreen.main.bounds)
        commonInit()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK:- UI Setup
    
    private func commonInit() {
       self.backgroundColor = StyleGuide.AppColors.backgroundColor
        setSubviews()
        setConstraints()
        
    }
    
    private func setSubviews() {
        self.addSubview(titleLabel)
        self.addSubview(stackView)
        self.addSubview(createButton)
    }
    
    private func setConstraints() {
        setTitleLabelConstraints()
        setupStackViewConstraints()
        setCreateAccountButtonConstraints()
    }
    
    private func setTitleLabelConstraints() {
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 30),
            titleLabel.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            titleLabel.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            titleLabel.heightAnchor.constraint(lessThanOrEqualTo: self.safeAreaLayoutGuide.heightAnchor, multiplier: 0.8)])
    }
    
    private func setupStackViewConstraints() {
        stackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 50),
            stackView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            stackView.heightAnchor.constraint(equalToConstant: 215),
            stackView.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.7)
        ])
    }
    
    private func setCreateAccountButtonConstraints() {
        createButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            createButton.topAnchor.constraint(equalTo: stackView.bottomAnchor, constant: 40),
            createButton.leadingAnchor.constraint(equalTo: stackView.leadingAnchor),
            createButton.trailingAnchor.constraint(equalTo: stackView.trailingAnchor),
            createButton.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
}


