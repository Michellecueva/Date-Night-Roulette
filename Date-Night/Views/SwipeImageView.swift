//
//  SwipeImageView.swift
//  Date-Night
//
//  Created by Phoenix McKnight on 3/12/20.
//  Copyright © 2020 Date Night Roulette. All rights reserved.
//

import UIKit

class SwipeImageView: UIImageView {
   
    
    var thumbSymbol = UIImageView(thumbImageView: "")
    private var thumbsUp:UIImage = UIImage(systemName: "hand.thumbsup")!.withRenderingMode(UIImage.RenderingMode.alwaysTemplate)
       
       private var thumbsDown:UIImage = UIImage(systemName:"hand.thumbsdown")!.withRenderingMode(UIImage.RenderingMode.alwaysTemplate)
    var thumbDirection:ThumbDirection? {
        didSet {
            switch thumbDirection {
            case .down:
                thumbSymbol.image = thumbsDown
            case .up:
                thumbSymbol.image = thumbsUp
            case .none:
                print("")
            }
        }
    }
  
    required convenience  init(angle: Double) {
      self.init(frame: CGRect.zero)
       
  }

  override init(frame: CGRect) {
      super.init(frame: CGRect.zero)
    self.isUserInteractionEnabled = true
    thumbSymbolConstraints()
    
  }
  required init?(coder aDecoder: NSCoder) {
      fatalError("init(coder:) has not been implemented")
  }
    
    private func thumbSymbolConstraints() {
        self.addSubview(thumbSymbol)
        thumbSymbol.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            thumbSymbol.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            thumbSymbol.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            thumbSymbol.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.5),
            thumbSymbol.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.5),
        ])
    }
}
