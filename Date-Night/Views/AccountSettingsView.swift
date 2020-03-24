//
//  SettingsView.swift
//  Date-Night
//
//  Created by Krystal Campbell on 3/24/20.
//  Copyright © 2020 Date Night Roulette. All rights reserved.
//

import UIKit

class SettingsView: UIView {
    
    lazy var accountLabel: UILabel = {
        let label1 = UILabel()
        label1.textColor = StyleGuide.TitleFontStyle.fontColor
        label1.text = "Account"
        label1.numberOfLines = 0
        label1.textAlignment = .center
        label1.textColor = .white
        label1.adjustsFontForContentSizeCategory = true
        label1.font = UIFont(name:StyleGuide.TitleFontStyle.fontName, size:StyleGuide.FontStyle.fontSize)
        return label1
    }()
    
    lazy var displayNameButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("User Name", for: .normal)
        button.setTitleColor(StyleGuide.ButtonStyle.fontColor, for: .normal)
        button.titleLabel?.font = UIFont(name: StyleGuide.ButtonStyle.fontName, size: StyleGuide.ButtonStyle.fontSize)
        button.backgroundColor = StyleGuide.ButtonStyle.backgroundColor
        button.layer.cornerRadius = StyleGuide.ButtonStyle.cornerRadius
        button.layer.borderColor = StyleGuide.ButtonStyle.borderColor
        button.layer.borderWidth = StyleGuide.ButtonStyle.altBorderWidth
        button.isEnabled = true
        return button
    }()
    
    
    lazy var removePartnerButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Disconnect from Partner", for: .normal)
        button.setTitleColor(StyleGuide.ButtonStyle.fontColor, for: .normal)
        button.titleLabel?.font = UIFont(name: StyleGuide.ButtonStyle.fontName, size: StyleGuide.ButtonStyle.fontSize)
        button.backgroundColor = StyleGuide.ButtonStyle.backgroundColor
        button.layer.cornerRadius = StyleGuide.ButtonStyle.cornerRadius
        button.layer.borderColor = StyleGuide.ButtonStyle.borderColor
        button.layer.borderWidth = StyleGuide.ButtonStyle.altBorderWidth
        button.isEnabled = true
        return button
    }()
    
    lazy var helpButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Help Center", for: .normal)
        button.setTitleColor(StyleGuide.ButtonStyle.fontColor, for: .normal)
        button.titleLabel?.font = UIFont(name: StyleGuide.ButtonStyle.fontName, size: StyleGuide.ButtonStyle.fontSize)
        button.backgroundColor = StyleGuide.ButtonStyle.backgroundColor
        button.layer.cornerRadius = StyleGuide.ButtonStyle.cornerRadius
        button.layer.borderColor = StyleGuide.ButtonStyle.borderColor
        button.layer.borderWidth = StyleGuide.ButtonStyle.altBorderWidth
        button.isEnabled = true
        return button
    }()
    
    
    lazy var notificationsButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Notifications", for: .normal)
        button.setTitleColor(StyleGuide.ButtonStyle.fontColor, for: .normal)
        button.titleLabel?.font = UIFont(name: StyleGuide.ButtonStyle.fontName, size: StyleGuide.ButtonStyle.fontSize)
        button.backgroundColor = StyleGuide.ButtonStyle.backgroundColor
        button.layer.cornerRadius = StyleGuide.ButtonStyle.cornerRadius
        button.layer.borderColor = StyleGuide.ButtonStyle.borderColor
        button.layer.borderWidth = StyleGuide.ButtonStyle.altBorderWidth
        button.isEnabled = true
        return button
    }()
    
    
    lazy var logoutButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Log Out", for: .normal)
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
        let stackView = UIStackView(arrangedSubviews: [accountLabel, displayNameButton, removePartnerButton, helpButton, notificationsButton, logoutButton])
        stackView.axis = .vertical
        stackView.spacing = 25
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
        self.addSubview(labelStackview)
    }
    
    
    private func addConstraints(){
        setStackViewConstraints()
    }
    
    
    
    private func setStackViewConstraints(){
        labelStackview.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            labelStackview.topAnchor.constraint(equalTo: self.topAnchor, constant: 120),
            labelStackview.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            labelStackview.heightAnchor.constraint(equalToConstant: 250),
            labelStackview.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.8)
        ])
    }
}
