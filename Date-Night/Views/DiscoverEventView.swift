//
//  DiscoverEventView.swift
//  Date-Night
//
//  Created by Kimball Yang on 2/6/20.
//  Copyright © 2020 Michelle Cueva. All rights reserved.
//

import UIKit

class DiscoverEventView: UIView {
    
    //   MARK:- Properties
    
    
    lazy var discoverEventButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Discover Events", for: .normal)
        button.setTitleColor(StyleGuide.ButtonStyle.fontColor, for: .normal)
        button.setTitleColor(StyleGuide.ButtonStyle.disabledColor, for: .disabled)
        button.titleLabel?.font = UIFont(name: StyleGuide.ButtonStyle.fontName, size: StyleGuide.ButtonStyle.fontSize)
        button.backgroundColor = StyleGuide.ButtonStyle.backgroundColor
        button.layer.cornerRadius = StyleGuide.ButtonStyle.cornerRadius
        button.layer.borderColor = StyleGuide.ButtonStyle.borderColor
        button.layer.borderWidth = StyleGuide.ButtonStyle.borderWidth
        button.isEnabled = false
        return button
    }()
    
    lazy var customActivityIndc:CustomIndictator = CustomIndictator(frame: .zero)

    lazy var randomEventButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Random Events", for: .normal)
        button.setTitleColor(StyleGuide.ButtonStyle.fontColor, for: .normal)
        button.titleLabel?.font = UIFont(name: StyleGuide.ButtonStyle.fontName, size: StyleGuide.ButtonStyle.fontSize)
        button.backgroundColor = StyleGuide.ButtonStyle.backgroundColor
        button.layer.cornerRadius = StyleGuide.ButtonStyle.cornerRadius
        button.layer.borderColor = StyleGuide.ButtonStyle.borderColor
        button.layer.borderWidth = StyleGuide.ButtonStyle.borderWidth
        button.isEnabled = true
        return button
    }()
    
    lazy var myPreferencesButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("My Preferences", for: .normal)
        button.setTitleColor(StyleGuide.ButtonStyle.fontColor, for: .normal)
        button.titleLabel?.font = UIFont(name: StyleGuide.ButtonStyle.fontName, size: StyleGuide.ButtonStyle.fontSize)
        button.backgroundColor = StyleGuide.ButtonStyle.backgroundColor
        button.layer.cornerRadius = StyleGuide.ButtonStyle.cornerRadius
        button.layer.borderColor = StyleGuide.ButtonStyle.borderColor
        button.layer.borderWidth = StyleGuide.ButtonStyle.borderWidth
        button.isEnabled = true
        return button
    }()
    
    lazy var buttonStackView: UIStackView = {
        
        let stackView = UIStackView(arrangedSubviews: [discoverEventButton, randomEventButton, myPreferencesButton])
        stackView.axis = .vertical
        stackView.spacing = 50
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
    
   
    
    
    private func commonInit() {
        setSubviews()
        setConstraints()
        self.backgroundColor = StyleGuide.AppColors.backgroundColor
        customActivityIndc.setToCenter(view: self, sizeRelativeToView: 0.2)
    }
    
    
    
    
    //MARK: -UI Setup
    
    private func setSubviews() {
        self.addSubview(buttonStackView)
        self.addSubview(customActivityIndc)
    }
    
    
    
    private func setConstraints() {
        
        buttonStackView.translatesAutoresizingMaskIntoConstraints = false
        buttonStackView.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant:0).isActive = true
        buttonStackView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: self.frame.width * 0.15).isActive = true
        buttonStackView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: self.frame.width * -0.15).isActive = true
        buttonStackView.heightAnchor.constraint(equalToConstant: self.frame.height * 0.5).isActive = true
        
    }
}
