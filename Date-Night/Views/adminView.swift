//
//  adminView.swift
//  Date-Night
//
//  Created by Phoenix McKnight on 2/23/20.
//  Copyright © 2020 Date Night Roulette. All rights reserved.
//

import UIKit

class AdminView: UIView {
    
    private let cellIdentifier = "PreferenceCell"


     lazy var addEventsButton: UIButton = {
            let button = UIButton(type: .system)
            button.setTitle("Add Events To Firebase", for: .normal)
            button.setTitleColor(.blue, for: .normal)
            button.titleLabel?.font = UIFont(name: "Arial-Bold", size: 16)
        button.backgroundColor = .clear
            button.layer.cornerRadius = 5
    
            return button
        }()
    
    lazy var getEventsFromAPIButton:UIButton = {
        let eventButton = UIButton(type: .system)
        eventButton.setTitle("Get events from API", for: .normal)
        eventButton.setTitleColor(.blue, for: .normal)
        eventButton.backgroundColor = .clear
        eventButton.layer.cornerRadius = 5
 
        return eventButton
    }()
    
    lazy var image:UIImageView = {
        let imageview = UIImageView()
        imageview.image = UIImage(named: "bouncer")
        imageview.contentMode = .scaleAspectFill
        return imageview
    }()
    
    lazy var adminLabel:UILabel = {
        let label = UILabel()
        label.text = "Admin Page"
        label.textAlignment = .center
        label.textColor = .white
        label.font = UIFont(name: "Arial-Bold", size: 24)
        return label
    }()
    
    lazy var preferenceCollectionView: UICollectionView = {
         var layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout.init()
         let cv = UICollectionView(frame: UIScreen.main.bounds, collectionViewLayout: layout)
         layout.scrollDirection = .vertical
         cv.backgroundColor = .clear
         layout.sectionInset = UIEdgeInsets(top: 0, left: 3, bottom: 0, right: 3)
         cv.register(PreferenceCell.self, forCellWithReuseIdentifier: cellIdentifier)
         cv.layer.borderColor = UIColor.black.cgColor
         cv.layer.borderWidth = 2
         return cv
     }()
        
        override init(frame: CGRect) {
            super.init(frame: UIScreen.main.bounds)
           commonInit()
           
            
        }
        
        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
        
       
        //MARK:- Private functions
        
        
        //MARK: -UI Setup
    
    private func commonInit() {
        setSubviews()
                   setConstraints()
                   self.setGradientBackground(colorTop: .black, colorBottom: .white)
    }
        
        private func setSubviews() {
            self.addSubview(adminLabel)
            self.addSubview(image)
            self.addSubview(addEventsButton)
            self.addSubview(getEventsFromAPIButton)
            self.addSubview(preferenceCollectionView)
        }
        
        private func setConstraints() {
            setAdminLabelConstraints()
            setImageConstraints()
            setAddEventButtonConstraints()
            setAPIButtonConstraints()
            setPrefCollectionViewConstraints()
        }
    
    private func setAdminLabelConstraints() {
        adminLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            adminLabel.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor,constant: self.frame.height * 0.1),
        adminLabel.heightAnchor.constraint(equalToConstant: self.frame.height * 0.1),
        adminLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor),
        adminLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor)])
    }
        
    private func setImageConstraints() {
        image.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            image.topAnchor.constraint(equalTo: adminLabel.bottomAnchor,constant: self.frame.height * 0.05),
        image.bottomAnchor.constraint(equalTo: self.centerYAnchor),
        image.leadingAnchor.constraint(equalTo: self.leadingAnchor),
        image.trailingAnchor.constraint(equalTo: self.trailingAnchor),
        ])
        
        
    }
    
        private func setAddEventButtonConstraints() {
            addEventsButton.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                addEventsButton.topAnchor.constraint(equalTo: image.bottomAnchor,constant: self.frame.height * 0.05),
                addEventsButton.centerXAnchor.constraint(equalTo: image.centerXAnchor),
                addEventsButton.widthAnchor.constraint(equalTo: image.widthAnchor, multiplier: 0.7),
                addEventsButton.heightAnchor.constraint(equalToConstant: 40)
            ])
        }
    
    private func setAPIButtonConstraints() {
        getEventsFromAPIButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            getEventsFromAPIButton.topAnchor.constraint(equalTo: addEventsButton.bottomAnchor,constant: self.frame.height * 0.05),
            getEventsFromAPIButton.centerXAnchor.constraint(equalTo: addEventsButton.centerXAnchor),
            getEventsFromAPIButton.heightAnchor.constraint(equalTo: addEventsButton.heightAnchor)
        ])
    }
    
    private func setPrefCollectionViewConstraints() {
        preferenceCollectionView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            preferenceCollectionView.topAnchor.constraint(equalTo: getEventsFromAPIButton.bottomAnchor),
            preferenceCollectionView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            preferenceCollectionView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            preferenceCollectionView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
    }
    }


