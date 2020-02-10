//
//  PreferencesView.swift
//  Date-Night
//
//  Created by Krystal Campbell on 2/7/20.
//  Copyright © 2020 Michelle Cueva. All rights reserved.
//

import UIKit

private let cellIdentifier = "preferenceCell"

class PreferencesView: UIView {
    
    lazy var preferencesCollectionView: UICollectionView = {
        var layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout.init()
        let cv = UICollectionView(frame: UIScreen.main.bounds, collectionViewLayout: layout)
        layout.itemSize = CGSize(width: 75, height: 75)
        layout.scrollDirection = .vertical
        cv.backgroundColor = #colorLiteral(red: 0.9086560607, green: 0.7275080085, blue: 1, alpha: 1)
        layout.sectionInset = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: -10)
        cv.register(preferenceCell.self, forCellWithReuseIdentifier: cellIdentifier)
        cv.layer.borderColor = UIColor.black.cgColor
        cv.layer.borderWidth = 2
        cv.layer.cornerRadius = 30
        return cv
    }()
    
    lazy var saveButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Save!", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = UIFont(name: "Marker Felt", size: 20)
        button.backgroundColor = #colorLiteral(red: 0.8556185365, green: 0.7159423232, blue: 0.9101250768, alpha: 1)
        button.layer.cornerRadius = 5
        // button.addTarget(self, action: #selector(savedPressed), for: .touchUpInside)
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: UIScreen.main.bounds)
        cvConstraints()
        buttonConstraints()
    
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func addSubviews() {
        self.addSubview(preferencesCollectionView)
        self.addSubview(saveButton)
    }
    //MARK:- constraints
    
    private func cvConstraints() {
        preferencesCollectionView.translatesAutoresizingMaskIntoConstraints = false
        preferencesCollectionView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 20).isActive = true
        preferencesCollectionView.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 15).isActive = true
        preferencesCollectionView.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -15).isActive = true
        //categoriesCollectionView.bottomAnchor.constraint(equalTo: saveButton.topAnchor, constant: -20).isActive = true
        preferencesCollectionView.heightAnchor.constraint(equalToConstant: 700).isActive = true
    }
    
    private func buttonConstraints(){
        saveButton.translatesAutoresizingMaskIntoConstraints = false
        saveButton.topAnchor.constraint(equalTo: preferencesCollectionView.bottomAnchor, constant: 15).isActive = true
        saveButton.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 90).isActive = true
        saveButton.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -90).isActive = true
        saveButton.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor, constant: -50)
    }
    
    
}
