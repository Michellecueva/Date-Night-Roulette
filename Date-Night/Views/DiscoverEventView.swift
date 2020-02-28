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
        button.setTitleColor(#colorLiteral(red: 1, green: 0.329310298, blue: 0.9998843074, alpha: 1), for: .normal)
         button.setTitleColor(#colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1), for: .disabled)
        button.titleLabel?.font = UIFont(name: "CopperPlate", size: 20)
        button.layer.borderColor = #colorLiteral(red: 0.9164920449, green: 0.7743749022, blue: 0.9852260947, alpha: 1)
        button.layer.borderWidth = 4
        button.layer.cornerRadius = 5
        button.isEnabled = false
        return button
    }()
    
    lazy var randomEventButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Random Events", for: .normal)
        button.setTitleColor(#colorLiteral(red: 1, green: 0.329310298, blue: 0.9998843074, alpha: 1), for: .normal)
        button.titleLabel?.font = UIFont(name: "CopperPlate", size: 20)
        button.layer.borderColor = #colorLiteral(red: 0.9164920449, green: 0.7743749022, blue: 0.9852260947, alpha: 1)
        button.layer.borderWidth = 4
        button.layer.cornerRadius = 5
        button.isEnabled = true
        return button
    }()
    
    lazy var myPreferencesButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("My Preferences", for: .normal)
        button.setTitleColor(#colorLiteral(red: 1, green: 0.329310298, blue: 0.9998843074, alpha: 1), for: .normal)
        button.titleLabel?.font = UIFont(name: "CopperPlate", size: 20)
        button.layer.borderColor = #colorLiteral(red: 0.9164920449, green: 0.7743749022, blue: 0.9852260947, alpha: 1)
        button.layer.borderWidth = 4
        button.layer.cornerRadius = 5
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
        self.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        setSubviews()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: Obj-C Methods
    
    
    
    
    //MARK:- Private functions
    
    
    //MARK: -UI Setup
    
        private func setSubviews() {
            self.addSubview(buttonStackView)
        }
    
   
   
    private func setConstraints() {
           
        buttonStackView.translatesAutoresizingMaskIntoConstraints = false
        buttonStackView.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant:0).isActive = true
        buttonStackView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: self.frame.width * 0.15).isActive = true
        buttonStackView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: self.frame.width * -0.15).isActive = true
        buttonStackView.heightAnchor.constraint(equalToConstant: self.frame.height * 0.5).isActive = true
        
}
}
