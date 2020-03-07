//
//  MatchedInfoView.swift
//  Date-Night
//
//  Created by Kimball Yang on 3/6/20.
//  Copyright © 2020 Date Night Roulette. All rights reserved.
//

import UIKit

class MatchedInfoView: UIView {

    lazy var matchedInfoTextView: UILabel = {
        let label = UILabel()
        label.backgroundColor = .blue
        label.textColor = .white
        label.text = """
        Placeholder text
        
        A zoo is a facility in which all animals are housed within enclosures, displayed to the public, and in which they may also breed. The term "zoological garden" refers to zoology, the study of animals, a term deriving from the Greek 'zoion, "animal," and logia, "study."
        
        """
        label.adjustsFontSizeToFitWidth = true
        label.font = UIFont(name: "Arial", size: 30)
        return label
    }()

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
        
    override init(frame: CGRect) {
        super.init(frame: UIScreen.main.bounds)
        addMatchSubviews()
        setMatchConstraints()

    }
    
    private func addMatchSubviews() {
//        self.addSubview(matchLabel)
//        self.addSubview(matchImage)
//        self.addSubview(confirmButton)
//        self.addSubview(moreInfoButton)
//        self.addSubview(directionButton)
//        self.addSubview(infoTextView)
//        self.addSubview(matchInfoDetailTextView)
    }
    
    private func setMatchConstraints() {
//        setMatchLabelConstraints()
//        setMatchImageConstraints()
//        setInfoTextViewConstraints()
//        setConfirmButtonConstraints()
//        setInfoButtonConstraints()
//        setDirectionButtonConstraints()
    }
    
    private func setTextViewConstraints() {
        matchedInfoTextView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            matchedInfoTextView.topAnchor.constraint(equalTo: self.topAnchor, constant: 30),
            matchedInfoTextView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            matchedInfoTextView.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.9),
            matchedInfoTextView.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.8)
        ])
        
        
        
    }
    
}
