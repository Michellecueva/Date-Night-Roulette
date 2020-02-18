//
//  preferenceCell.swift
//  Date-Night
//
//  Created by Krystal Campbell on 2/7/20.
//  Copyright © 2020 Michelle Cueva. All rights reserved.
//

import UIKit

class PreferenceCell: UICollectionViewCell {
    
    lazy var preferenceLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 2
        label.textAlignment = .center
        label.font = UIFont(name: "CopperPlate", size: 18.0)
        label.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        label.adjustsFontSizeToFitWidth = true
        label.layer.cornerRadius = 10
        label.backgroundColor = .clear
        return label
    }()
    
    var isAddedToPreferenceArray:Bool = false {
        didSet {
            switchBackgroundColorOfCell(bool: isAddedToPreferenceArray)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview()
        prefLabelConstraints()
        self.backgroundColor = #colorLiteral(red: 0.9164920449, green: 0.7743749022, blue: 0.9852260947, alpha: 1)
        
    }
    
    private func addSubview(){
        contentView.addSubview(preferenceLabel)
    }
    
    private func prefLabelConstraints(){
        preferenceLabel.translatesAutoresizingMaskIntoConstraints = false
        preferenceLabel.widthAnchor.constraint(equalTo: contentView.widthAnchor).isActive = true
        preferenceLabel.heightAnchor.constraint(equalTo: contentView.heightAnchor).isActive = true
        preferenceLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        preferenceLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
    }
    
    private func switchBackgroundColorOfCell(bool:Bool) {
        switch bool {
        case true:
            self.backgroundColor = .gray
        case false:
            self.backgroundColor = #colorLiteral(red: 0.9164920449, green: 0.7743749022, blue: 0.9852260947, alpha: 1)
        }
    }
}

