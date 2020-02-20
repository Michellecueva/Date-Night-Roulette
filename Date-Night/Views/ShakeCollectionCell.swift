//
//  ShakeCollectionCell.swift
//  Date-Night
//
//  Created by Kimball Yang on 2/18/20.
//  Copyright © 2020 Michelle Cueva. All rights reserved.
//

import UIKit

class ShakeCollectionCell: UICollectionViewCell {
    
    lazy var shakeImage: UIImageView = {
       let image = UIImageView()
        image.image = UIImage(named: "LIONKING-superJumbo")
        return image
    }()
    
    lazy var shakeInfoEye: UIButton = {
        let button = UIButton()
//        button.backgroundColor = .green
        button.setImage(UIImage(systemName: "eye"), for: .normal)
        button.addTarget(target.self, action: #selector(animateShowInfo), for: .touchUpInside)
        return button
    }()
    
    lazy var shakeInfoDetailTextView: UITextView = {
        let textview = UITextView()
        textview.backgroundColor = .gray
        textview.alpha = 0.5
        textview.layer.shadowColor = .init(srgbRed: 0.5, green: 0.5, blue: 0.5, alpha: 0.5)
        textview.adjustsFontForContentSizeCategory = true
        textview.textColor = .yellow
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
    
    private func setSubviews() {
        self.addSubview(shakeImage)
        self.addSubview(shakeInfoEye)
        self.addSubview(shakeInfoDetailTextView)
    }
    @objc func animateShowInfo(_ viewToAnimate:UITextView)  {
        UIView.animate(withDuration: 1, delay: 0, usingSpringWithDamping: 0.25, initialSpringVelocity: 0.5, options: .curveEaseInOut, animations: {
            self.shakeInfoDetailTextView.alpha = 0
            viewToAnimate.transform = CGAffineTransform(scaleX: 0.0, y: 0.0)
        })
    }
    
    private func setConstraints() {
        setShakeImageConstraint()
        setShakeInfoEyeConstraints()
        
        setInfoDetailConstraints()
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
    
}
