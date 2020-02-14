//
//  ProfileView.swift
//  Date-Night
//
//  Created by Phoenix McKnight on 2/10/20.
//  Copyright © 2020 Michelle Cueva. All rights reserved.
//

import UIKit
import FirebaseAuth

class ProfileSettingView: UIView {
    
    var user: AppUser!
    
    //MARK: Portrait
    
    lazy var portraitPic: UIImageView = {
        let image = UIImageView()
        image.tintColor = #colorLiteral(red: 0.9092509151, green: 0.7310814261, blue: 1, alpha: 1)
        image.image = UIImage(systemName: "person.crop.circle.badge.plus")
        return image
    }()
    
    lazy var userNameLabel: UILabel = {
        let label = UILabel()
        label.text = "Hi, userName!"
        label.font = UIFont(name: "CopperPlate", size: 25)
        label.textAlignment = .center
        label.textColor = #colorLiteral(red: 0.9164920449, green: 0.7743749022, blue: 0.9852260947, alpha: 1)
        return label
    }()
    
    lazy var partnerEmailLabel: UILabel = {
        let label = UILabel()
        label.text = "Partner Email:"
        label.textAlignment = .center
        label.font = UIFont(name: "Arial", size: 25)
        label.textColor = #colorLiteral(red: 0.9164920449, green: 0.7743749022, blue: 0.9852260947, alpha: 1)
        return label
    }()
    
    lazy var partnerEmailDisplayLabel: UILabel = {
        let label = UILabel()
        label.text = "Email goes here"
        label.textAlignment = .center
        label.font = UIFont(name: "Arial", size: 25)
        label.textColor = #colorLiteral(red: 0.9164920449, green: 0.7743749022, blue: 0.9852260947, alpha: 1)
        return label
    }()

    lazy var logoutButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Logout", for: .normal)
        button.setTitleColor(#colorLiteral(red: 0.9092509151, green: 0.7310814261, blue: 1, alpha: 1), for: .normal)
        button.titleLabel?.font = UIFont(name: "CopperPlate", size: 20)
        button.layer.borderColor = #colorLiteral(red: 0.9092509151, green: 0.7310814261, blue: 1, alpha: 1)
        button.layer.borderWidth = 1
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
        self.addSubview(partnerEmailLabel)
        self.addSubview(partnerEmailDisplayLabel)
        self.addSubview(logoutButton)
        
    }
    
    
    private func setConstraints() {
        setPortraitConstraints()
        setUserNameLabelConstraints()
        setPartnerEmailLabelConstraints()
        setPartnerEmailDisplayConstraints()
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
    
    
    private func setPartnerEmailLabelConstraints() {
        partnerEmailLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            partnerEmailLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: self.frame.height * 0.45),
            partnerEmailLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor, constant: -50),
            partnerEmailLabel.widthAnchor.constraint(equalToConstant: 200),
            partnerEmailLabel.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
    
    private func setPartnerEmailDisplayConstraints(){
        partnerEmailDisplayLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            partnerEmailDisplayLabel.topAnchor.constraint(equalTo: partnerEmailLabel.bottomAnchor, constant: 10),
            partnerEmailDisplayLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            partnerEmailDisplayLabel.widthAnchor.constraint(equalToConstant: 300),
            partnerEmailDisplayLabel.heightAnchor.constraint(equalToConstant: 40)
            
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

