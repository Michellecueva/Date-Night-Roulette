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
        label.font = UIFont(name: StyleGuide.TitleFontStyle.fontName, size: StyleGuide.TitleFontStyle.fontSize)
        label.adjustsFontSizeToFitWidth = true

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
        textField.tag = 0
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
        textField.tag = 1
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
        textField.tag = 2
        return textField
    }()
    
    lazy var warningImageEmail:UIImageView = {
           let newImage = UIImageView()
           newImage.image = UIImage(systemName: "exclamationmark.triangle")
                         newImage.contentMode = .scaleAspectFit
                  newImage.tintColor = .white
        newImage.isHidden = true
        newImage.alpha = 0.0
           return newImage
       }()
    
    lazy var warningImagePassword:UIImageView = {
              let newImage = UIImageView()
              newImage.image = UIImage(systemName: "exclamationmark.triangle")
                            newImage.contentMode = .scaleAspectFit
                     newImage.tintColor = .white
        newImage.isHidden = true
        newImage.alpha = 0.0

              return newImage
          }()
    
    lazy var warningImageConfirmPassword:UIImageView = {
              let newImage = UIImageView()
              newImage.image = UIImage(systemName: "exclamationmark.triangle")
                            newImage.contentMode = .scaleAspectFit
                     newImage.tintColor = .white
        newImage.isHidden = true
        newImage.alpha = 0.0

              return newImage
          }()
    
       
       lazy var emailTextFieldStack:UIStackView = {
           let stackView = UIStackView(
                    arrangedSubviews: [
                       self.emailTextField,
                       self.warningImageEmail
                    ]
                )
                stackView.axis = .horizontal
                stackView.spacing = 5
                stackView.distribution = .fillProportionally
                return stackView
       }()
    
    lazy var passWordTextFieldStack:UIStackView = {
        let stackView = UIStackView(
                 arrangedSubviews: [
                    self.passwordTextField,
                    self.warningImagePassword
                 ]
             )
             stackView.axis = .horizontal
             stackView.spacing = 5
             stackView.distribution = .fillProportionally
             return stackView
    }()
    
    lazy var confirmPasswordTextFieldStack:UIStackView = {
        let stackView = UIStackView(
                 arrangedSubviews: [
                    self.confirmPasswordTextField,
                    self.warningImageConfirmPassword
                 ]
             )
             stackView.axis = .horizontal
             stackView.spacing = 5
             stackView.distribution = .fillProportionally
             return stackView
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
                emailTextFieldStack,
                passWordTextFieldStack,
                confirmPasswordTextFieldStack
            ]
        )
        stackView.axis = .vertical
        stackView.spacing = 25
        stackView.distribution = .fill
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
        self.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
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
        setDisplayNameConstraints()
        setEmailTextViewConstraints()
        setPassWordTextViewConstraints()
        setConfirmPasswordTextViewConstraints()
        setWarningImageEmailConstraints()
        setWarningImagePasswordConstraints()
        setWarningImageConfirmPasswordConstraints()
        setupStackViewConstraints()
        setCreateAccountButtonConstraints()
        
    }
    
    private func setTitleLabelConstraints() {
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: self.frame.height * 0.05),
            titleLabel.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor),
            titleLabel.heightAnchor.constraint(equalToConstant: self.frame.height * 0.1)
        ])
    }
    
    private func setEmailTextViewConstraints() {
        NSLayoutConstraint.activate([
        emailTextField.heightAnchor.constraint(equalToConstant: self.frame.height * 0.05),
                 emailTextField.widthAnchor.constraint(equalToConstant: self.frame.width * 0.8)
        ])
    }
    
    private func setDisplayNameConstraints() {
           NSLayoutConstraint.activate([
            displayName.heightAnchor.constraint(equalToConstant: self.frame.height * 0.05),
            displayName.widthAnchor.constraint(equalToConstant: self.frame.width * 0.8)
                  ])
       }
    
    private func setPassWordTextViewConstraints() {
           NSLayoutConstraint.activate([
                  passwordTextField.heightAnchor.constraint(equalToConstant: self.frame.height * 0.05),
                           passwordTextField.widthAnchor.constraint(equalToConstant: self.frame.width * 0.8)
                  ])
       }
    
    private func setConfirmPasswordTextViewConstraints() {
           NSLayoutConstraint.activate([
                  confirmPasswordTextField.heightAnchor.constraint(equalToConstant: self.frame.height * 0.05),
                           confirmPasswordTextField.widthAnchor.constraint(equalToConstant: self.frame.width * 0.8)
                  ])
       }
    
    private func setupStackViewConstraints() {
        stackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: self.frame.height * 0.05),
            stackView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            stackView.heightAnchor.constraint(equalToConstant: self.frame.height * 0.3),
            stackView.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.8)
        ])
    }
    
    private func setCreateAccountButtonConstraints() {
        createButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            createButton.topAnchor.constraint(equalTo: stackView.bottomAnchor, constant: self.frame.height * 0.05),
            createButton.leadingAnchor.constraint(equalTo: stackView.leadingAnchor,constant: self.frame.width * 0.05),
            createButton.trailingAnchor.constraint(equalTo: stackView.trailingAnchor,constant: -self.frame.width * 0.05),
            createButton.heightAnchor.constraint(equalToConstant: self.frame.height * 0.05)
        ])
    }
    
private func setWarningImageEmailConstraints() {
    warningImageEmail.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
        warningImageEmail.heightAnchor.constraint(equalToConstant: self.frame.height * 0.05),
        warningImageEmail.widthAnchor.constraint(equalToConstant: self.frame.width * 0.05)
        
    ])
    }
    private func setWarningImagePasswordConstraints() {
    warningImagePassword.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
        warningImagePassword.heightAnchor.constraint(equalToConstant: self.frame.height * 0.05),
        warningImagePassword.widthAnchor.constraint(equalToConstant: self.frame.width * 0.05)
        
    ])
    }
    private func setWarningImageConfirmPasswordConstraints() {
    warningImageConfirmPassword.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
        warningImageConfirmPassword.heightAnchor.constraint(equalToConstant: self.frame.height * 0.05),
        warningImageConfirmPassword.widthAnchor.constraint(equalToConstant: self.frame.width * 0.05)
        
    ])
    }
}


