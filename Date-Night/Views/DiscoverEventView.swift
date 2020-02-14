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
        button.setTitleColor(.blue, for: .normal)
        button.titleLabel?.font = UIFont(name: "Arial-Bold", size: 16)
        button.backgroundColor = #colorLiteral(red: 0.9164920449, green: 0.7743749022, blue: 0.9852260947, alpha: 1)
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
    
    //MARK: Obj-C Methods
    
    
    
    
    //MARK:- Private functions
    
    
    //MARK: -UI Setup
    
    private func setSubviews() {
        self.addSubview(discoverEventButton)
    }
    
    private func setConstraints() {
        setDiscoverButtonConstraints()
    }
    
    private func setDiscoverButtonConstraints() {
        discoverEventButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            discoverEventButton.topAnchor.constraint(equalTo: self.topAnchor,constant: self.frame.height * 0.3),
            discoverEventButton.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            discoverEventButton.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.7),
            discoverEventButton.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
}
