//
//  MatchedEventView.swift
//  Date-Night
//
//  Created by Kimball Yang on 3/3/20.
//  Copyright © 2020 Date Night Roulette. All rights reserved.
//

import UIKit

class MatchedEventView: UIView {
    
    
    var imageTopConstraint = NSLayoutConstraint()
    var labelTopConstraint = NSLayoutConstraint()
    
    private var state: State = .collapsed
    
    lazy var matchLabel: UILabel = {
        let mLabel = UILabel()
        mLabel.textColor = #colorLiteral(red: 0.9164920449, green: 0.7743749022, blue: 0.9852260947, alpha: 1)
        mLabel.text = "You and your partner have matched an event!"
        mLabel.numberOfLines = 0
        mLabel.textAlignment = .center
        mLabel.adjustsFontForContentSizeCategory = true
        mLabel.font = UIFont(name: "CopperPlate", size: 25)
        return mLabel
    }()
    
    lazy var matchImage: UIImageView = {
        let mImage = UIImageView()
        mImage.backgroundColor = .brown
        mImage.image = UIImage(named: "LIONKING-superJumbo")
        return mImage
    }()
    
    lazy var confirmButton: UIButton = {
        let button = UIButton()
        button.setTitle("Confirm", for: .normal)
        button.setTitleColor(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 1), for: .normal)
        button.backgroundColor = #colorLiteral(red: 0.9164920449, green: 0.7743749022, blue: 0.9852260947, alpha: 1)
        button.titleLabel?.font = UIFont(name: "Arial", size: 24)
        button.layer.cornerRadius = 10
        button.isEnabled = true
        return button
    }()
    
    lazy var shakeImage: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "LIONKING-superJumbo")
        return image
    }()
    
    
    
    lazy var moreInfoButton: UIButton = {
        let infoButton = UIButton()
        infoButton.backgroundColor = #colorLiteral(red: 0.9164920449, green: 0.7743749022, blue: 0.9852260947, alpha: 1)
        infoButton.layer.cornerRadius = 10
        infoButton.setTitle("More Info", for: .normal)
        infoButton.setTitleColor(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 1), for: .normal)
        infoButton.addTarget(self, action: #selector(animateMatchView), for: .touchUpInside)
        return infoButton
    }()
    
    lazy var directionButton: UIButton = {
        let dirButton = UIButton()
        dirButton.backgroundColor = #colorLiteral(red: 0.9164920449, green: 0.7743749022, blue: 0.9852260947, alpha: 1)
        dirButton.layer.cornerRadius = 10
        dirButton.setTitle("Directions", for: .normal)
        dirButton.setTitleColor(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 1), for: .normal)
        
        return dirButton
    }()
    
    lazy var infoTextView: UITextView = {
        let textview = UITextView()
        textview.backgroundColor = .lightGray
        textview.font = UIFont(name: "Arial", size: 30)
        textview.adjustsFontForContentSizeCategory = true
        return textview
    }()
    
    lazy var matchInfoDetailTextView: UITextView = {
        let textview = UITextView()
        textview.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        textview.alpha = 0.0
        textview.layer.shadowColor = .init(srgbRed: 0.5, green: 0.5, blue: 0.5, alpha: 0.9)
        textview.adjustsFontForContentSizeCategory = true
        textview.font = UIFont(name: "Arial", size: 30)
        textview.isUserInteractionEnabled = false
        textview.textColor = #colorLiteral(red: 0.9164920449, green: 0.7743749022, blue: 0.9852260947, alpha: 1)
        return textview
    }()
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(frame: CGRect) {
        super.init(frame: UIScreen.main.bounds)
        addMatchSubviews()
        setMatchConstraints()
//        labelTopConstraint.constant = 150
//        imageTopConstraint.constant = 250
    }
    
    enum State {
        case expanded
        case collapsed
        
        var change: State {
            switch self {
            case .expanded:
                return .collapsed
            case .collapsed:
                return .expanded
            }
        }
    }
    
    @objc func animateMatchView()  {
            
        UIView.animate(withDuration: 1, delay: 0.2, usingSpringWithDamping: 0.3, initialSpringVelocity: 0.1, options: .curveEaseInOut, animations: {
                
                switch self.state {
            
                    case .collapsed:
            
                        self.imageTopConstraint.constant = 250
                        self.labelTopConstraint.constant = 150
                        self.layoutIfNeeded()
                        self.state = self.state.change
                        print("collapsed")
            
                    case .expanded:
                               
                        self.imageTopConstraint.constant = 0
                        self.labelTopConstraint.constant = 30
                        self.layoutIfNeeded()
                        self.state = self.state.change
                        
                        print("expanded")
            
                }
            })
        }
    
    private func addMatchSubviews() {
        self.addSubview(matchLabel)
        self.addSubview(matchImage)
        self.addSubview(confirmButton)
        self.addSubview(moreInfoButton)
        self.addSubview(directionButton)
        self.addSubview(matchInfoDetailTextView)
    }
    
    private func setMatchConstraints() {
        setMatchLabelConstraints()
        setMatchImageConstraints()
        setConfirmButtonConstraints()
        setInfoButtonConstraints()
        setDirectionButtonConstraints()
    }
    
    private func setMatchLabelConstraints() {
        matchLabel.translatesAutoresizingMaskIntoConstraints = false
        
        labelTopConstraint = matchLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 150)
        
        matchLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 40).isActive = true
        matchLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -40).isActive = true
        matchLabel.heightAnchor.constraint(equalToConstant: 90).isActive = true
        NSLayoutConstraint.activate([labelTopConstraint])
    }
    
    private func setMatchImageConstraints() {
        matchImage.translatesAutoresizingMaskIntoConstraints = false
        
        imageTopConstraint = matchImage.topAnchor.constraint(equalTo: self.topAnchor, constant: 250)
        
        matchImage.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        matchImage.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        matchImage.heightAnchor.constraint(equalToConstant: (self.frame.height * 0.46) - 60).isActive = true
        NSLayoutConstraint.activate([imageTopConstraint])
    }
    
    private func setConfirmButtonConstraints() {
        confirmButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            confirmButton.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -90),
            confirmButton.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            confirmButton.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.4),
            confirmButton.heightAnchor.constraint(equalToConstant: 30)
        ])
    }
    
    private func setInfoButtonConstraints() {
        moreInfoButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            moreInfoButton.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -160),
            moreInfoButton.centerXAnchor.constraint(equalTo: self.centerXAnchor, constant: -100),
            moreInfoButton.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.3),
            moreInfoButton.heightAnchor.constraint(equalToConstant: 30)
        ])
    }
    
    private func setDirectionButtonConstraints() {
        directionButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            directionButton.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -160),
            directionButton.centerXAnchor.constraint(equalTo: self.centerXAnchor, constant: 100),
            directionButton.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.3),
            directionButton.heightAnchor.constraint(equalToConstant: 30)
        ])
    }
    
    private func setMatchInfoDetailTextViewConstraints() {
        matchInfoDetailTextView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            matchInfoDetailTextView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            matchInfoDetailTextView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            matchInfoDetailTextView.widthAnchor.constraint(equalTo: self.widthAnchor),
            matchInfoDetailTextView.heightAnchor.constraint(equalTo: self.heightAnchor)
        ])
    }
    
    
}
