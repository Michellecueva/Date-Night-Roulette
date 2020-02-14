//
//  ProfileView.swift
//  Date-Night
//
//  Created by Phoenix McKnight on 2/10/20.
//  Copyright © 2020 Michelle Cueva. All rights reserved.
//

import UIKit

class ProfileSettingView: UIView {

    //MARK: Portrait
    
    lazy var portraitPic: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(systemName: "person.crop.circle.badge.plus")
        return image
    }()

    lazy var userNameLabel: UILabel = {
        let label = UILabel()
        label.text = "Hi, userName!"
        label.font = UIFont(name: "CopperPlate", size: 20)
        label.textAlignment = .center
        label.textColor = #colorLiteral(red: 0.9164920449, green: 0.7743749022, blue: 0.9852260947, alpha: 1)
        return label
    }()

    lazy var userEmailFieldLabel: UILabel = {
        let label = UILabel()
        label.text = "User Email"
        label.font = UIFont(name: "Arial", size: 25)
        label.textColor = #colorLiteral(red: 0.9164920449, green: 0.7743749022, blue: 0.9852260947, alpha: 1)
        return label
    }()

    lazy var partnerEmailFieldLabel: UILabel = {
        let label = UILabel()
        label.text = "Partner Email"
        label.font = UIFont(name: "CopperPlate", size: 25)
        label.textColor = #colorLiteral(red: 0.9164920449, green: 0.7743749022, blue: 0.9852260947, alpha: 1)
        return label
    }()


    lazy var emailField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Email Address"
        textField.borderStyle = .roundedRect
        textField.backgroundColor = #colorLiteral(red: 0.9164920449, green: 0.7743749022, blue: 0.9852260947, alpha: 1)
        return textField
    }()

    lazy var partnerField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Password"
        textField.borderStyle = .roundedRect
        textField.backgroundColor = #colorLiteral(red: 0.9164920449, green: 0.7743749022, blue: 0.9852260947, alpha: 1)
        textField.isSecureTextEntry = true
        return textField
    }()
    lazy var logoutButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Logout", for: .normal)
        button.setTitleColor(#colorLiteral(red: 0.9164920449, green: 0.7743749022, blue: 0.9852260947, alpha: 1), for: .normal)
        button.titleLabel?.font = UIFont(name: "CopperPlate", size: 20)
        button.layer.cornerRadius = 5
        button.isEnabled = true
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
        self.addSubview(portraitPic)
        self.addSubview(userNameLabel)
        self.addSubview(userEmailFieldLabel)
        self.addSubview(partnerEmailFieldLabel)
        self.addSubview(emailField)
        self.addSubview(partnerField)
        self.addSubview(logoutButton)

    }

    private func setConstraints() {
        setPortraitConstraints()
        setUserNameLabelConstraints()
        setUserEmailLabelConstraints()
        setEmailFieldConstraints()
        setPartnerEmailLabelConstraints()
        setPartnerFieldConstraints()
        setLogOutButtonConstraints()
    }

    private func setPortraitConstraints() {
        portraitPic.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            portraitPic.topAnchor.constraint(equalTo: self.topAnchor, constant: self.frame.height * 0.1),
            portraitPic.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            portraitPic.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.5),
            portraitPic.heightAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.4)
        ])
    }

    private func setUserNameLabelConstraints() {
        userNameLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            userNameLabel.topAnchor.constraint(equalTo: portraitPic.bottomAnchor, constant: 10),
            userNameLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            userNameLabel.widthAnchor.constraint(equalToConstant: 200),
            userNameLabel.heightAnchor.constraint(equalToConstant: 40)
        ])
    }

    private func setUserEmailLabelConstraints() {
        userEmailFieldLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            userEmailFieldLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: self.frame.height * 0.45),
            userEmailFieldLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor, constant: -50),
            userEmailFieldLabel.widthAnchor.constraint(equalToConstant: 200),
            userEmailFieldLabel.heightAnchor.constraint(equalToConstant: 50)
        ])
    }

    private func setEmailFieldConstraints() {
        emailField.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            emailField.topAnchor.constraint(equalTo: userEmailFieldLabel.bottomAnchor, constant:  10),
            emailField.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            emailField.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.7),
            emailField.heightAnchor.constraint(equalToConstant: 40)
        ])
    }

    //partnerEmailFieldLabel
    private func setPartnerEmailLabelConstraints() {
        partnerEmailFieldLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            partnerEmailFieldLabel.topAnchor.constraint(equalTo: emailField.bottomAnchor, constant: 30),
            partnerEmailFieldLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor, constant: -50),
            partnerEmailFieldLabel.widthAnchor.constraint(equalToConstant: 200),
            partnerEmailFieldLabel.heightAnchor.constraint(equalToConstant: 40)
        ])
    }

    private func setPartnerFieldConstraints() {
        partnerField.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            partnerField.topAnchor.constraint(equalTo: partnerEmailFieldLabel.bottomAnchor, constant: 10),
            partnerField.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            partnerField.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.7),
            partnerField.heightAnchor.constraint(equalToConstant: 40)
        ])
    }

    private func setLogOutButtonConstraints() {
        logoutButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            logoutButton.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -50),
            logoutButton.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            logoutButton.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.2),
            logoutButton.heightAnchor.constraint(equalToConstant: 30)
        ])
    }
}
