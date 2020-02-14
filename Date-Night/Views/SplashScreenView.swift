//
//  SplashScreenView.swift
//  Date-Night
//
//  Created by Kimball Yang on 2/14/20.
//  Copyright © 2020 Michelle Cueva. All rights reserved.
//

import UIKit

class SplashScreenView: UIView {

    lazy var splashLogo: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "splashLogo.png")
        return image
    }()
    
    private func rotateSplashLogo() {
    UIView.animate(withDuration: 2.0, animations: {
        self.splashLogo.transform = CGAffineTransform(rotationAngle: (180.0 * .pi) / 180.0)
            }
        )

    }
    
    override init(frame: CGRect) {
        super.init(frame: UIScreen.main.bounds)
        self.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        setSubviews()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    
    private func setSubviews() {
        self.addSubview(splashLogo)
    }
    
    private func setConstraints() {
        splashLogo.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            splashLogo.topAnchor.constraint(equalTo: self.topAnchor, constant: self.frame.height * 0.3),
            splashLogo.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.8),
            splashLogo.heightAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.8),
            splashLogo.centerXAnchor.constraint(equalTo: self.centerXAnchor)
        ])
        
        
    }
    
    
}
