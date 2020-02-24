//
//  ShakeGestureView.swift
//  TestShake
//
//  Created by Kimball Yang on 2/23/20.
//  Copyright © 2020 Kimball Yang. All rights reserved.
//


import UIKit

private let shakeCellIdentifier = "ShakeCollectionCell"

class ShakeGestureView: UIView {
    
    
    
    lazy var shakeLabel: UILabel = {
        let label = UILabel()
        label.textColor = #colorLiteral(red: 0.9164920449, green: 0.7743749022, blue: 0.9852260947, alpha: 1)
        label.text = "Shake for\nnext experience"
        label.numberOfLines = 0
        label.textAlignment = .center
//        label.backgroundColor = .blue
        label.adjustsFontForContentSizeCategory = true
        label.font = UIFont(name: "CopperPlate", size: 40)
        return label
    }()
    
    
    lazy var shakeCollectionView: UICollectionView = {
        var layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout.init()
        let cv = UICollectionView(frame: UIScreen.main.bounds, collectionViewLayout: layout)
        layout.itemSize = CGSize(width: 380, height: 380)
        layout.scrollDirection = .horizontal
//        cv.backgroundColor = .gray
        layout.sectionInset = UIEdgeInsets(top: 10, left: 30, bottom: 10, right: 30)
        cv.register(ShakeCollectionCell.self, forCellWithReuseIdentifier: shakeCellIdentifier)
        cv.layer.borderColor = UIColor.black.cgColor
        cv.layer.borderWidth = 2
//        cv.isUserInteractionEnabled = false
        return cv
    }()
    
    
    lazy var confirmButton: UIButton = {
        let button = UIButton()
        button.setTitle("It's a date!", for: .normal)
        button.setTitleColor(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 1), for: .normal)
        button.backgroundColor = #colorLiteral(red: 0.9164920449, green: 0.7743749022, blue: 0.9852260947, alpha: 1)
        button.titleLabel?.font = UIFont(name: "Arial", size: 24)
        button.layer.cornerRadius = 5
        button.isEnabled = true
        return button
    }()
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(frame: CGRect) {
        super.init(frame: UIScreen.main.bounds)
        addShakeSubviews()
        setShakeConstraints()
        
    }
    
//    static func scrollToNextCell(){

//        //get Collection View Instance
//        let collectionView:shakeCollectionView;
//
        //get cell size
//        let cellSize = CGSize(width: 380, height: 380)
//
//        //get current content Offset of the Collection view
//        let contentOffset = shakeCollectionView.contentOffset

        //scroll to next cell
//        shakeCollectionView.scrollRectToVisible(CGRect(x: shakeCollectionView.contentOffset.x + 380, y: shakeCollectionView.contentOffset.y, width: 380, height: 380), animated: true)
//
//
//    }
    
//    static func snapToNearestCell(_ collectionView: UICollectionView) {
//        for i in 0..<collectionView.numberOfItems(inSection: 0) {
//
//            let itemWithSpaceWidth = collectionViewFlowLayout.itemSize.width + collectionViewFlowLayout.minimumLineSpacing
//            let itemWidth = collectionViewFlowLayout.itemSize.width
//
//            if collectionView.contentOffset.x <= CGFloat(i) * itemWithSpaceWidth + itemWidth / 2 {
//                let indexPath = IndexPath(item: i, section: 0)
//                collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
//                break
//            }
//        }
//    }
    
    private func addShakeSubviews() {
        self.addSubview(shakeLabel)
        self.addSubview(shakeCollectionView)
        self.addSubview(confirmButton)
        
    }
    
    private func setShakeConstraints() {
        setShakeLabelConstraints()
        setShakeCollectionConstraints()
        setConfirmButtonConstraints()
    }
    
    
    
    private func setShakeLabelConstraints() {
        shakeLabel.translatesAutoresizingMaskIntoConstraints = false
        shakeLabel.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 60).isActive = true
        shakeLabel.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 40).isActive = true
        shakeLabel.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -40).isActive = true
        shakeLabel.heightAnchor.constraint(equalToConstant: 90).isActive = true
    }
    
//
//    private func setPendingStatusConstraint() {
//          waitingStatusLabel.translatesAutoresizingMaskIntoConstraints = false
//          NSLayoutConstraint.activate([
//              waitingStatusLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: self.frame.height * 0.50),
//              waitingStatusLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
//              waitingStatusLabel.widthAnchor.constraint(equalToConstant: 300),
//              waitingStatusLabel.heightAnchor.constraint(equalToConstant: 40)
//          ])
//      }
    private func setShakeCollectionConstraints() {
        shakeCollectionView.translatesAutoresizingMaskIntoConstraints = false
        shakeCollectionView.topAnchor.constraint(equalTo: self.shakeLabel.bottomAnchor, constant: 30).isActive = true
          shakeCollectionView.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor).isActive = true
          shakeCollectionView.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor).isActive = true
        shakeCollectionView.heightAnchor.constraint(equalToConstant: self.frame.height * 0.46).isActive = true
        print(self.frame.height * 0.46)
    }
    
    private func setConfirmButtonConstraints() {
        confirmButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            confirmButton.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -150),
            confirmButton.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            confirmButton.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.5),
            confirmButton.heightAnchor.constraint(equalToConstant: 30)
        ])
    }
    
}

/*
 private func setupConstraints() {
   eventCollectionView.translatesAutoresizingMaskIntoConstraints = false
   eventCollectionView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor).isActive = true
   eventCollectionView.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor).isActive = true
   eventCollectionView.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor).isActive = true
 eventCollectionView.heightAnchor.constraint(equalTo:self.safeAreaLayoutGuide.heightAnchor).isActive = true
 }
  
 private func buttonConstraints(){
   detailViewButton.translatesAutoresizingMaskIntoConstraints = false
   detailViewButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
   detailViewButton.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 90).isActive = true
   detailViewButton.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -90).isActive = true
   detailViewButton.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor, constant: -50).isActive = true
 }

 */
