//
//  OBDisplayNameSetupView.swift
//  Date-Night
//
//  Created by Krystal Campbell on 3/20/20.
//  Copyright © 2020 Date Night Roulette. All rights reserved.
//

import UIKit

class OBDisplayNameSetupView: UIView {
    
    
    lazy var displayNameLabel: UILabel = {
        let label1 = UILabel()
        label1.textColor = StyleGuide.TitleFontStyle.fontColor
        label1.text = "Hi, Whats your name?"
        label1.numberOfLines = 0
        label1.textAlignment = .center
        label1.textColor = .white
        label1.adjustsFontForContentSizeCategory = true
        label1.font = UIFont(name:StyleGuide.TitleFontStyle.fontName, size:StyleGuide.FontStyle.fontSize)
        return label1
    }()
    
    lazy var descriptionLabel: UILabel = {
        let label1 = UILabel()
        label1.textColor = StyleGuide.TitleFontStyle.fontColor
        label1.text = "We will use this as your display name and share with your partner."
        label1.numberOfLines = 0
        label1.textAlignment = .center
        label1.textColor = .white
        label1.adjustsFontForContentSizeCategory = true
        label1.font = UIFont(name:StyleGuide.TitleFontStyle.fontName, size:StyleGuide.FontStyle.fontSize)
        return label1
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
    
    lazy var nextButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Next", for: .normal)
        button.setTitleColor(StyleGuide.ButtonStyle.fontColor, for: .normal)
        button.titleLabel?.font = UIFont(name: StyleGuide.ButtonStyle.fontName, size: StyleGuide.ButtonStyle.fontSize)
        button.backgroundColor = StyleGuide.ButtonStyle.backgroundColor
        button.layer.cornerRadius = StyleGuide.ButtonStyle.cornerRadius
        button.layer.borderColor = StyleGuide.ButtonStyle.borderColor
        button.layer.borderWidth = StyleGuide.ButtonStyle.altBorderWidth
        button.isEnabled = true
        return button
    }()
    
    lazy var labelStackview: UIStackView = {
           let stackView = UIStackView(arrangedSubviews: [displayNameLabel, descriptionLabel,displayName, nextButton])
           stackView.axis = .vertical
           stackView.spacing = 40
           stackView.distribution = .fillEqually
           return stackView
       }()
    
    override init(frame: CGRect) {
           super.init(frame: UIScreen.main.bounds)
           self.backgroundColor = StyleGuide.AppColors.backgroundColor
           commonInit()
       }
       
       required init?(coder: NSCoder) {
           fatalError("init(coder:) has not been implemented")
       }
       
       private func commonInit(){
           addSubviews()
           addConstraints()
       }
       
       private func addSubviews() {
           //self.addSubview(notifServices)
           self.addSubview(labelStackview)
          // self.addSubview(notifEnabled)
       }
       
       
       private func addConstraints(){
          // setNotifConstraints()
           setStackViewConstraints()
          // setNotifSwitchConstraints()
       }
       
       
//       private func setNotifConstraints(){
//           notifServices.translatesAutoresizingMaskIntoConstraints = false
//           NSLayoutConstraint.activate([
//           notifServices.topAnchor.constraint(equalTo: self.topAnchor, constant: self.frame.height * 0.25),
//           notifServices.centerXAnchor.constraint(equalTo: self.centerXAnchor),
//           notifServices.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.2),
//           notifServices.heightAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.2)
//                 ])
//
//
//       }
       
       private func setStackViewConstraints(){
           labelStackview.translatesAutoresizingMaskIntoConstraints = false
           NSLayoutConstraint.activate([
            labelStackview.topAnchor.constraint(equalTo: self.topAnchor, constant: 120),
           labelStackview.centerXAnchor.constraint(equalTo: self.centerXAnchor),
           labelStackview.heightAnchor.constraint(equalToConstant: 250),
           labelStackview.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.8)
           ])
       }
//       
//       private func setNotifSwitchConstraints(){
//           notifEnabled.translatesAutoresizingMaskIntoConstraints = false
//           NSLayoutConstraint.activate([
//           notifEnabled.topAnchor.constraint(equalTo: labelStackview.bottomAnchor, constant: 120),
//           notifEnabled.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 160),
//           notifEnabled.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -50),
//           notifEnabled.heightAnchor.constraint(equalToConstant: 80)
//           ])
//       }
}
