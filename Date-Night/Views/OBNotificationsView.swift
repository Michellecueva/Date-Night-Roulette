//
//  OBNotificationsView.swift
//  Date-Night
//
//  Created by Krystal Campbell on 3/20/20.
//  Copyright © 2020 Date Night Roulette. All rights reserved.
//

import UIKit

class OBNotificationsView: UIView {
    
    lazy var notifServices: UIButton = {
        let button = UIButton()
        button.setBackgroundImage(UIImage(systemName: "bell.slash"), for: .normal)
        button.tintColor = #colorLiteral(red: 0.9092509151, green: 0.7310814261, blue: 1, alpha: 1)
        button.showsTouchWhenHighlighted = true
        button.isEnabled = true
        return button
    }()
    
    lazy var enableNotifLabel: UILabel = {
        let label1 = UILabel()
        label1.textColor = StyleGuide.TitleFontStyle.fontColor
        label1.text = "Enable Push Notifications"
        label1.numberOfLines = 0
        label1.textAlignment = .center
        label1.textColor = .white
        label1.adjustsFontForContentSizeCategory = true
        label1.font = UIFont(name:StyleGuide.TitleFontStyle.fontName, size:StyleGuide.FontStyle.fontSize)
        return label1
    }()
    
    lazy var notifDescriptionLabel: UILabel = {
        let label1 = UILabel()
        label1.textColor = StyleGuide.TitleFontStyle.fontColor
        label1.text = "We'll notify you on the important things only like when you and your partner match on an experience and more."
        label1.numberOfLines = 0
        label1.textAlignment = .center
        label1.textColor = .white
        label1.adjustsFontForContentSizeCategory = true
        label1.font = UIFont(name:StyleGuide.TitleFontStyle.fontName, size:StyleGuide.FontStyle.fontSize)
        return label1
    }()
    
    lazy var onOffNotifLabel: UILabel = {
        let label1 = UILabel()
        label1.textColor = StyleGuide.TitleFontStyle.fontColor
        label1.text = "Needs to be hidden until Notifications Enabled!"
        label1.numberOfLines = 0
        label1.textAlignment = .center
        label1.textColor = .white
        label1.adjustsFontForContentSizeCategory = true
        label1.font = UIFont(name:StyleGuide.TitleFontStyle.fontName, size:StyleGuide.FontStyle.fontSize)
        return label1
    }()
    
    lazy var notifEnabled: UISwitch = {
        let notifSwitch = UISwitch()
        //  notifSwitch.isOn = false
        notifSwitch.onTintColor = #colorLiteral(red: 0.9092509151, green: 0.7310814261, blue: 1, alpha: 1)
        notifSwitch.setOn(false, animated: true)
        // notifSwitch.thumbTintColor
        return notifSwitch
    }()
    
    lazy var labelStackview: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [enableNotifLabel, notifDescriptionLabel, onOffNotifLabel])
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
        self.addSubview(notifServices)
        self.addSubview(labelStackview)
        self.addSubview(notifEnabled)
    }
    
    
    private func addConstraints(){
        setNotifConstraints()
        setStackViewConstraints()
        setNotifSwitchConstraints()
    }
    
    
    private func setNotifConstraints(){
        notifServices.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
        notifServices.topAnchor.constraint(equalTo: self.topAnchor, constant: self.frame.height * 0.25),
        notifServices.centerXAnchor.constraint(equalTo: self.centerXAnchor),
        notifServices.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.2),
        notifServices.heightAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.2)
              ])
             
        
    }
    
    private func setStackViewConstraints(){
        labelStackview.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
        labelStackview.topAnchor.constraint(equalTo: notifServices.bottomAnchor, constant: 120),
        labelStackview.centerXAnchor.constraint(equalTo: self.centerXAnchor),
        labelStackview.heightAnchor.constraint(equalToConstant: 150),
        labelStackview.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.9)
        ])
    }
    
    private func setNotifSwitchConstraints(){
        notifEnabled.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
        notifEnabled.topAnchor.constraint(equalTo: labelStackview.bottomAnchor, constant: 120),
        notifEnabled.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 160),
        notifEnabled.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -50),
        notifEnabled.heightAnchor.constraint(equalToConstant: 80)
        ])
    }
}
