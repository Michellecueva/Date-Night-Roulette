//
//  OBLocationServicesView.swift
//  Date-Night
//
//  Created by Krystal Campbell on 3/20/20.
//  Copyright © 2020 Date Night Roulette. All rights reserved.
//

import UIKit

class OBLocationServicesView: UIView {
    
    
    lazy var locationServices: UIButton = {
        let button = UIButton()
        button.setBackgroundImage(UIImage(systemName: "location.slash"), for: .normal)
        button.tintColor = #colorLiteral(red: 0.9092509151, green: 0.7310814261, blue: 1, alpha: 1)
        button.showsTouchWhenHighlighted = true
        button.isEnabled = true
        return button
    }()
    
    lazy var enableLocationLabel: UILabel = {
        let label1 = UILabel()
        label1.textColor = StyleGuide.TitleFontStyle.fontColor
        label1.text = "Enable Location Services"
        label1.numberOfLines = 0
        label1.textAlignment = .center
        label1.textColor = .white
        label1.adjustsFontForContentSizeCategory = true
        label1.font = UIFont(name:StyleGuide.TitleFontStyle.fontName, size:StyleGuide.FontStyle.fontSize)
        return label1
    }()
    
    lazy var locationDescriptionLabel: UILabel = {
        let label1 = UILabel()
        label1.textColor = StyleGuide.TitleFontStyle.fontColor
        label1.text = "We will use your location to map out directions for your future dates."
        label1.numberOfLines = 0
        label1.textAlignment = .center
        label1.textColor = .white
        label1.adjustsFontForContentSizeCategory = true
        label1.font = UIFont(name:StyleGuide.TitleFontStyle.fontName, size:StyleGuide.FontStyle.fontSize)
        return label1
    }()
    
    lazy var onOffLocationLabel: UILabel = {
        let label1 = UILabel()
        label1.textColor = StyleGuide.TitleFontStyle.fontColor
        label1.text = "Needs to be hidden until Location Services Enabled!"
        label1.numberOfLines = 0
        label1.textAlignment = .center
        label1.textColor = .white
        label1.adjustsFontForContentSizeCategory = true
        label1.font = UIFont(name:StyleGuide.TitleFontStyle.fontName, size:StyleGuide.FontStyle.fontSize)
        return label1
    }()
    
    lazy var locationEnabled: UISwitch = {
        let notifSwitch = UISwitch()
        //  notifSwitch.isOn = false
        notifSwitch.onTintColor = #colorLiteral(red: 0.9092509151, green: 0.7310814261, blue: 1, alpha: 1)
        notifSwitch.setOn(false, animated: true)
        // notifSwitch.thumbTintColor
        return notifSwitch
    }()
    
    lazy var labelStackview: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [enableLocationLabel, locationDescriptionLabel, onOffLocationLabel])
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
        self.addSubview(locationServices)
        self.addSubview(labelStackview)
        self.addSubview(locationEnabled)
    }
    
    
    private func addConstraints(){
        setNotifConstraints()
        setStackViewConstraints()
        setNotifSwitchConstraints()
    }
    
    
    private func setNotifConstraints(){
       locationServices.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
        locationServices.topAnchor.constraint(equalTo: self.topAnchor, constant: self.frame.height * 0.25),
        locationServices.centerXAnchor.constraint(equalTo: self.centerXAnchor),
        locationServices.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.2),
        locationServices.heightAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.2)
        ])
        
        
    }
    
    private func setStackViewConstraints(){
        labelStackview.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            labelStackview.topAnchor.constraint(equalTo: locationServices.bottomAnchor, constant: 120),
            labelStackview.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            labelStackview.heightAnchor.constraint(equalToConstant: 150),
            labelStackview.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.9)
        ])
    }
    
    private func setNotifSwitchConstraints(){
        locationEnabled.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
        locationEnabled.topAnchor.constraint(equalTo: labelStackview.bottomAnchor, constant: 120),
        locationEnabled.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 160),
        locationEnabled.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -50),
        locationEnabled.heightAnchor.constraint(equalToConstant: 80)
        ])
    }
}
