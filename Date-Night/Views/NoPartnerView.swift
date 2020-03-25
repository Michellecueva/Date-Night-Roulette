//
//  NoPartnerView.swift
//  Date-Night
//
//  Created by Krystal Campbell on 3/25/20.
//  Copyright © 2020 Date Night Roulette. All rights reserved.
//

import UIKit

class NoPartnerView: UIView {
    
    lazy var sadLogoImage: UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage(named: "SadLogo")
        iv.clipsToBounds = true
        iv.contentMode = .scaleToFill
        iv.backgroundColor = .clear
        return iv
    }()
    
    
    lazy var noPartnerLabel: UILabel = {
        let label1 = UILabel()
        label1.textColor = StyleGuide.TitleFontStyle.fontColor
        label1.text = "No Partner"
        label1.numberOfLines = 0
        label1.textAlignment = .center
        label1.textColor = .white
        label1.adjustsFontForContentSizeCategory = true
        label1.font = UIFont(name:StyleGuide.TitleFontStyle.fontName, size:StyleGuide.FontStyle.altFontSize)
        return label1
    }()
    
    lazy var descriptionLabel:UILabel = {
        let uiLabel = UILabel()
        uiLabel.adjustsFontSizeToFitWidth = true
        uiLabel.font = UIFont(name: StyleGuide.FontStyle.fontName, size: StyleGuide.FontStyle.fontSize)
        uiLabel.numberOfLines = 0
        uiLabel.textAlignment = .center
        uiLabel.textColor = StyleGuide.FontStyle.fontColor
        uiLabel.text = "Invite your partner now, so you can discover events and get to matching!"
        return uiLabel
    }()
    
    
    lazy var sendInviteButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Send Invite", for: .normal)
        button.setTitleColor(StyleGuide.ButtonStyle.fontColor, for: .normal)
        button.titleLabel?.font = UIFont(name: StyleGuide.ButtonStyle.fontName, size: StyleGuide.ButtonStyle.fontSize)
        button.backgroundColor = StyleGuide.ButtonStyle.backgroundColor
        button.layer.cornerRadius = StyleGuide.ButtonStyle.cornerRadius
        button.layer.borderColor = StyleGuide.ButtonStyle.borderColor
        button.layer.borderWidth = StyleGuide.ButtonStyle.borderWidth
        button.isEnabled = true
        return button
    }()
    
    lazy var labelStackview: UIStackView = {
          let stackView = UIStackView(arrangedSubviews: [noPartnerLabel, descriptionLabel, sendInviteButton])
          stackView.axis = .vertical
          stackView.spacing = 25
          stackView.distribution = .fillEqually
          return stackView
      }()
      
      override init(frame: CGRect) {
          super.init(frame: UIScreen.main.bounds)
          self.backgroundColor = StyleGuide.AppColors.backgroundColor
          commonInit()
      }
      
      required init?(coder: NSCoder) {
          fatalError("init(coder:) has not been implemented")
      }
    
    private func commonInit(){
          addSubviews()
          addConstraints()
      }
      
      private func addSubviews() {
          self.addSubview(sadLogoImage)
          self.addSubview(labelStackview)
      }
    
    private func addConstraints(){
        setImageConstraints()
        setStackViewConstraints()
    }
    
    private func setImageConstraints(){
         sadLogoImage.translatesAutoresizingMaskIntoConstraints = false
          NSLayoutConstraint.activate([
          sadLogoImage.topAnchor.constraint(equalTo: self.topAnchor, constant: self.frame.height * 0.2),
          sadLogoImage.centerXAnchor.constraint(equalTo: self.centerXAnchor),
          sadLogoImage.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.65),
          sadLogoImage.heightAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.6)
          ])
          
          
      }
      
      private func setStackViewConstraints(){
          labelStackview.translatesAutoresizingMaskIntoConstraints = false
          NSLayoutConstraint.activate([
              labelStackview.topAnchor.constraint(equalTo: sadLogoImage.bottomAnchor, constant: 80),
              labelStackview.centerXAnchor.constraint(equalTo: self.centerXAnchor),
              labelStackview.heightAnchor.constraint(equalToConstant: 150),
              labelStackview.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.9)
          ])
      }
}
