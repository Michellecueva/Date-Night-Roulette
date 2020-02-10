//
//  PreferencesView.swift
//  Date-Night
//
//  Created by Krystal Campbell on 2/7/20.
//  Copyright © 2020 Michelle Cueva. All rights reserved.
//

import UIKit

private let cellIdentifier = "PreferenceCell"

class PreferenceView: UIView {
    
    lazy var preferenceCollectionView: UICollectionView = {
        var layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout.init()
        let cv = UICollectionView(frame: UIScreen.main.bounds, collectionViewLayout: layout)
        layout.itemSize = CGSize(width: 125, height: 125)
        layout.scrollDirection = .vertical
        cv.backgroundColor = .clear
        layout.sectionInset = UIEdgeInsets(top: 30, left: 3, bottom: 0, right: 3)
        cv.register(PreferenceCell.self, forCellWithReuseIdentifier: cellIdentifier)
        cv.layer.borderColor = UIColor.black.cgColor
        cv.layer.borderWidth = 2
        return cv
    }()
    
    
    lazy var saveButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Save!", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = UIFont(name: "Marker Felt", size: 20)
        button.backgroundColor = #colorLiteral(red: 0.9164920449, green: 0.7743749022, blue: 0.9852260947, alpha: 1)
        button.layer.cornerRadius = 5
        // button.addTarget(self, action: #selector(savedPressed), for: .touchUpInside)
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: UIScreen.main.bounds)
        addSubviews()
        cvConstraints()
        buttonConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func addSubviews() {
        self.addSubview(preferenceCollectionView)
        self.addSubview(saveButton)
    }
    //MARK:- Constraints
    
    private func cvConstraints() {
        preferenceCollectionView.translatesAutoresizingMaskIntoConstraints = false
        preferenceCollectionView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor).isActive = true
        preferenceCollectionView.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor).isActive = true
        preferenceCollectionView.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor).isActive = true
        preferenceCollectionView.heightAnchor.constraint(equalTo:self.safeAreaLayoutGuide.heightAnchor).isActive = true
    }
    
    private func buttonConstraints(){
        saveButton.translatesAutoresizingMaskIntoConstraints = false
        saveButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        saveButton.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 90).isActive = true
        saveButton.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -90).isActive = true
        saveButton.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor, constant: -50).isActive = true
    }
    
    
}