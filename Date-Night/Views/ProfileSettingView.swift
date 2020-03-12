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
    
    
    //MARK: Portrait
    
    lazy var portraitPic: UIImageView = {
        let image = UIImageView(frame: UIScreen.main.bounds)
        image.tintColor = #colorLiteral(red: 0.9092509151, green: 0.7310814261, blue: 1, alpha: 1)
        image.image = UIImage(named: "PortraitPlaceholder")
        image.layer.borderWidth = 1
        image.layer.cornerRadius = 84 //frame.size.width / 2 //image.bounds.width / 2 //84 //image.frame.size.height/2
        image.layer.masksToBounds = true
        image.layer.borderColor = UIColor.black.cgColor
        //image.clipsToBounds = true
        image.contentMode = .scaleToFill
        //image.image = UIImage(systemName: "person.crop.circle")
        return image
    }()
    
    lazy var addPictureButton: UIButton = {
          let button = UIButton()
          button.setBackgroundImage(UIImage(systemName: "plus.circle.fill"), for: .normal)
          button.tintColor = #colorLiteral(red: 0.9092509151, green: 0.7310814261, blue: 1, alpha: 1)
          button.showsTouchWhenHighlighted = true
          button.isEnabled = true
          //button.imageEdgeInsets = UIEdgeInsets(top: 10, left: 0, bottom: 0, right: 0)
          button.layer.backgroundColor = UIColor.black.cgColor
          //button.layer.cornerRadius = 
          return button
      }()
    
    lazy var userNameLabel: UILabel = {
        let label = UILabel()
        label.text = "Hi user!"
        label.adjustsFontSizeToFitWidth = true
        label.font = UIFont(name: StyleGuide.FontStyle.fontName, size: StyleGuide.FontStyle.altFontSize)
        label.textAlignment = .center
        label.textColor = StyleGuide.FontStyle.fontColor
        return label
    }()
    
    lazy var partnerEmailLabel: UILabel = {
        let label = UILabel()
        label.text = "Partner Email:"
        label.textAlignment = .center
        label.font = UIFont(name: StyleGuide.FontStyle.fontName, size: StyleGuide.FontStyle.altFontSize)
        label.textColor = StyleGuide.FontStyle.fontColor
        return label
    }()
    
    lazy var partnerEmailDisplayLabel: UILabel = {
        let label = UILabel()
        label.text = "Partner Email"
        label.font = UIFont(name: "CopperPlate", size: 17)
        label.text = "Email goes here"
        label.textAlignment = .center
        label.textColor = #colorLiteral(red: 0.9164920449, green: 0.7743749022, blue: 0.9852260947, alpha: 1)
        return label
    }()
/*
    lazy var noEventsLabel: UILabel = {
          let label = UILabel()
          label.text = "No Event History"
          label.font = UIFont(name:StyleGuide.FontStyle.fontName, size: StyleGuide.FontStyle.altFontSize)
          label.adjustsFontSizeToFitWidth = true
          label.textAlignment = .center
          label.textColor = #colorLiteral(red: 0.9164920449, green: 0.7743749022, blue: 0.9852260947, alpha: 1)
          return label
      }()
    */
    lazy var logoutButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Logout", for: .normal)
        button.setTitleColor(StyleGuide.ButtonStyle.fontColor, for: .normal)
        button.titleLabel?.font = UIFont(name: StyleGuide.ButtonStyle.fontName, size: StyleGuide.ButtonStyle.fontSize)
        button.backgroundColor = StyleGuide.ButtonStyle.backgroundColor
        button.layer.cornerRadius = StyleGuide.ButtonStyle.cornerRadius
        button.layer.borderColor = StyleGuide.ButtonStyle.borderColor
        button.layer.borderWidth = StyleGuide.ButtonStyle.altBorderWidth
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
        self.addSubview(addPictureButton)
        self.addSubview(userNameLabel)
        self.addSubview(partnerEmailLabel)
        self.addSubview(partnerEmailDisplayLabel)
        self.addSubview(logoutButton)
        
    }
    
    
    private func setConstraints() {
        setPortraitConstraints()
        setAddButtonConstraints()
        setUserNameLabelConstraints()
        setPartnerEmailLabelConstraints()
        setPartnerEmailDisplayConstraints()
        setLogOutButtonConstraints()
    }
    
    
    
    private func setPortraitConstraints() {
        portraitPic.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            portraitPic.topAnchor.constraint(equalTo: self.topAnchor, constant: self.frame.height * 0.15),
            portraitPic.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            portraitPic.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.4),
            portraitPic.heightAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.4)
        ])
       
    }
    
    private func setAddButtonConstraints(){
        addPictureButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            addPictureButton.bottomAnchor.constraint(equalTo: portraitPic.bottomAnchor),
            addPictureButton.centerXAnchor.constraint(equalTo: self.centerXAnchor, constant: 60),
           // addPictureButton.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 250),
            addPictureButton.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.12),
            addPictureButton.heightAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.12)
        ])
    }
    
    private func setUserNameLabelConstraints() {
        userNameLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            userNameLabel.topAnchor.constraint(equalTo: addPictureButton.bottomAnchor, constant: 25),
            userNameLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            userNameLabel.widthAnchor.constraint(equalToConstant: 200),
            userNameLabel.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
    
    
    private func setPartnerEmailLabelConstraints() {
        partnerEmailLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            partnerEmailLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: self.frame.height * 0.45),
            partnerEmailLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
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
            partnerEmailDisplayLabel.heightAnchor.constraint(equalToConstant: 45)
            
        ])
    }
    
    private func setLogOutButtonConstraints() {
        logoutButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            logoutButton.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -70),
            logoutButton.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            logoutButton.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.25),
            logoutButton.heightAnchor.constraint(equalToConstant: 35)
        ])
    }
}

