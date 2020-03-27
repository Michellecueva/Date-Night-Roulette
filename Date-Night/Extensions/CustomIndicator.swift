//
//  CustomIndicator.swift
//  Date-Night
//
//  Created by Phoenix McKnight on 3/26/20.
//  Copyright © 2020 Date Night Roulette. All rights reserved.
//

import UIKit

class CustomIndictator: UIImageView {

    override init(frame: CGRect) {
          super.init(frame: frame)
          commonInit()
      }

      required init?(coder: NSCoder) {
          super.init(coder: coder)
          commonInit()
      }
    
    private func commonInit() {
      setUpIndicator()
    }
    private func setUpIndicator() {
         self.contentMode = .scaleAspectFit
         self.clipsToBounds = true
         self.image = UIImage(named:"splashLogo")
         self.beginAnimation()
    }
    
    public func setToCenter(view:UIView, sizeRelativeToView:CGFloat) {
        
        self.frame = CGRect(x: 0, y: 0, width: view.frame.width * sizeRelativeToView, height: view.frame.height * sizeRelativeToView)
        self.center = view.center
    }
    
    public func stopAnimatingAndHide() {
        self.removeFromSuperview()
    }
}
