//
//  ShakeCollectionCell.swift
//  Date-Night
//
//  Created by Kimball Yang on 2/18/20.
//  Copyright © 2020 Michelle Cueva. All rights reserved.
//

import UIKit


class ShakeCollectionCell: UICollectionViewCell {
    
    var infoTopConstraint = NSLayoutConstraint()
    var infoLeadConstraint = NSLayoutConstraint()
//    var shakeDelegate:
    
    lazy var shakeImage: UIImageView = {
       let image = UIImageView()
        image.image = UIImage(named: "LIONKING-superJumbo")
        return image
    }()
    
    lazy var shakeInfoEye: UIButton = {
        let button = UIButton()
//        button.backgroundColor = .green
        button.setImage(UIImage(systemName: "eye"), for: .normal)
        button.isUserInteractionEnabled = true
        button.addTarget(self, action: #selector(animateShowInfo), for: .touchUpInside)
        return button
    }()
    
    lazy var shakeInfoDetailTextView: UITextView = {
        let textview = UITextView()
        textview.backgroundColor = #colorLiteral(red: 0.3647058904, green: 0.06666667014, blue: 0.9686274529, alpha: 1)
        textview.alpha = 0.0
        textview.layer.shadowColor = .init(srgbRed: 0.5, green: 0.5, blue: 0.5, alpha: 0.9)
        textview.adjustsFontForContentSizeCategory = true
        textview.font = UIFont(name: "Arial", size: 30)
        textview.isUserInteractionEnabled = false
        textview.textColor = .clear
        textview.text = """
Seeing The Lion King on Broadway is a life-changing experience. To be fair, I was five, but still, having a giraffe touch my nose? Something I’ll never forget.
"""
        return textview
    }()
       
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .red
        setSubviews()
        setConstraints()
//        shakeInfoDetailTextView.isHidden = true
        
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private enum State {
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
    
    //Mark: Properties
    
    private var initialFrame: CGRect?
    private var state: State = .collapsed
    private var collectionView: UICollectionView?
    private var index: Int?
    
    
//    private func collapse() {
//
//        UIView.animate(withDuration: 0.3, delay: 0.0, options: .curveEaseIn, animations: {
//            guard let collectionView = self.collectionView, let index = self.index else {return}
//
////            self.actionSheetButton.alpha = 0
////            self.authorName.alpha = 0
//
//            self.shakeInfoDetailTextView.alpha = 0
//            self.shakeInfoEye.alpha = 0
//
//            self.shakeImage.transform = CGAffineTransform(translationX: 0, y: 0)
//            self.shakeImage.transform = CGAffineTransform(translationX: 1, y: 1)
//
//            self.shakeInfoDetailTextView.transform = CGAffineTransform(translationX: 0, y: 0)
//
//
//        self.frame = self.initialFrame!
//
//        if let upCell = collectionView.cellForItem(at: IndexPath.init(row: index - 1, section: 0)) {
//            //Animates left Cell fading out when cell expands
//
//            UIView.animate(withDuration: 0.3, delay: 0.0, options: .curveEaseInOut, animations: {
//                upCell.center.y += 50
//                upCell.alpha = 1
//            }, completion: nil)
//
//        }
//        if let downCell = collectionView.cellForItem(at: IndexPath.init(row: index + 1, section: 0)) {
//
//            UIView.animate(withDuration: 0.3, delay: 0.0, options: .curveEaseInOut, animations: {
//                downCell.center.y -= 50
//                downCell.alpha = 1
//            }, completion: nil)
//
//        }
//
//        self.layoutIfNeeded()
//    }) { (finished) in
//        self.state = self.state.change
//        self.collectionView?.isScrollEnabled = true
//        self.collectionView?.allowsSelection = true
//        }
//}

        
//    private func expand() {
//        UIView.animate(withDuration: 0.3, delay: 0.0, options: .transitionFlipFromRight, animations: {
//            guard let collectionView = self.collectionView, let index = self.index else {return}
//
//            self.initialFrame = self.frame
////            self.actionSheetButton
//            self.shakeInfoDetailTextView.alpha = 1
//            self.shakeInfoEye.alpha = 1
//            self.shakeImage.transform = CGAffineTransform(translationX: 0, y:-225)
//            self.shakeInfoDetailTextView.transform = CGAffineTransform(translationX: 0, y:-200)
//
//            self.frame = CGRect(x: 0, y: collectionView.contentOffset.y, width: collectionView.frame.width, height: collectionView.frame.height)
//
//            if let upCell = collectionView.cellForItem(at: IndexPath.init(row: index - 1, section: 0)) {
//
//                UIView.animate(withDuration: 0.3, delay: 0.0, options: .curveEaseInOut, animations: {
//                    upCell.center.y -= 50
//                    upCell.alpha = 0
//                }, completion: nil)
//            }
//
//            self.layoutIfNeeded()
//
//        }) { (finished) in
//            self.state = self.state.change
//            self.collectionView?.isScrollEnabled = false
//            self.collectionView?.allowsSelection = false
//        }
//    }
    
    private func setSubviews() {
        self.contentView.addSubview(shakeImage)
        self.contentView.addSubview(shakeInfoEye)
        self.contentView.addSubview(shakeInfoDetailTextView)
    }
    @objc func animateShowInfo(_ viewToAnimate:UITextView)  {
        
        
        UIView.animate(withDuration: 2, delay: 0, usingSpringWithDamping: 0.9, initialSpringVelocity: 0.3, options: .curveEaseInOut, animations: {
            switch self.state {
            case .collapsed:
                self.infoLeadConstraint.constant = 0
                self.infoTopConstraint.constant = 70
                self.contentView.layoutIfNeeded()
                self.shakeInfoDetailTextView.textColor = .yellow
                self.shakeInfoDetailTextView.alpha = 0.7
                self.state = .expanded
            case.expanded:
                self.infoLeadConstraint.constant = self.contentView.frame.width - 40
                self.infoTopConstraint.constant = self.contentView.frame.height - 40
                self.contentView.layoutIfNeeded()
                self.shakeInfoDetailTextView.alpha = 0.0
                self.shakeInfoDetailTextView.textColor = .clear
                self.state = .collapsed
            }
            
            
//            self.shakeInfoDetailTextView.alpha = 0
//            viewToAnimate.transform = CGAffineTransform(scaleX: 0.0, y: 0.0)
        })
    }
    
    private func setConstraints() {
        setShakeImageConstraint()
        setShakeInfoEyeConstraints()
         //setInfoDetailConstraints()
        collapseInfoDetailConstraints()
       
    }
    
    private func setShakeImageConstraint() {
        shakeImage.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            shakeImage.topAnchor.constraint(equalTo: self.topAnchor),
            shakeImage.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            shakeImage.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            shakeImage.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
    }
    
    private func setShakeInfoEyeConstraints() {
        shakeInfoEye.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            shakeInfoEye.bottomAnchor.constraint(equalTo: self.shakeImage.bottomAnchor),
            shakeInfoEye.trailingAnchor.constraint(equalTo: self.shakeImage.trailingAnchor),
            shakeInfoEye.leadingAnchor.constraint(equalTo: self.shakeImage.trailingAnchor, constant: -40),
            shakeInfoEye.topAnchor.constraint(equalTo: self.shakeImage.bottomAnchor, constant: -40),
//            shakeInfoEye.heightAnchor.constraint(equalToConstant: 50),
//            shakeInfoEye.widthAnchor.constraint(equalToConstant: 50)
            
        
        ])
    }
    
    private func setInfoDetailConstraints() {
        shakeInfoDetailTextView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            shakeInfoDetailTextView.topAnchor.constraint(equalTo: self.shakeImage.topAnchor, constant: 70),
            shakeInfoDetailTextView.trailingAnchor.constraint(equalTo: self.shakeImage.trailingAnchor),
            shakeInfoDetailTextView.leadingAnchor.constraint(equalTo: self.shakeImage.leadingAnchor),
            shakeInfoDetailTextView.bottomAnchor.constraint(equalTo: self.shakeImage.bottomAnchor)
        
        ])
        
        
    }
    
    
    private func collapseInfoDetailConstraints() {
        shakeInfoDetailTextView.translatesAutoresizingMaskIntoConstraints = false
        infoTopConstraint = shakeInfoDetailTextView.topAnchor.constraint(equalTo: self.shakeImage.topAnchor, constant: contentView.frame.height - 40)
        infoLeadConstraint = shakeInfoDetailTextView.leadingAnchor.constraint(equalTo: self.shakeImage.leadingAnchor, constant: contentView.frame.width - 40)
        NSLayoutConstraint.activate([
            shakeInfoDetailTextView.bottomAnchor.constraint(equalTo: self.shakeImage.bottomAnchor),
            shakeInfoDetailTextView.trailingAnchor.constraint(equalTo: self.shakeImage.trailingAnchor),
//            shakeInfoDetailTextView.leadingAnchor.constraint(equalTo: self.shakeImage.leadingAnchor, constant: contentView.frame.width - 40),
//            shakeInfoDetailTextView.topAnchor.constraint(equalTo: self.shakeImage.topAnchor, constant: contentView.frame.height - 40),
            infoTopConstraint,
            infoLeadConstraint
        
        ])
        
    }
    
    
}
