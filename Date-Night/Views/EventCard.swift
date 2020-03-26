//
//  EventCard.swift
//  EventView
//
//  Created by Phoenix McKnight on 3/12/20.
//  Copyright © 2020 Phoenix McKnight. All rights reserved.
//

import UIKit

class EventCard: UIView {
    
    lazy var  titleLabel:UILabel = {
        let tl = UILabel()
        tl.textColor = StyleGuide.TitleFontStyle.fontColor
            tl.numberOfLines = 0
            tl.textAlignment = .center
        tl.alpha = 0.0
           
            tl.font = UIFont(name:StyleGuide.TitleFontStyle.fontName, size:StyleGuide.TitleFontStyle.altFontSize)
        tl.adjustsFontSizeToFitWidth  = true
        return tl
    }()
    let imageView:UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFit
        iv.clipsToBounds = true
        return iv
    }()
    let detailView = EventCardDetailView()
    

    lazy var tapGesture: UITapGestureRecognizer = {
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.handleTap(tap:)))
        return tap
    }()
    
    var isDisplayingDetailView: Bool {
        return detailView.superview == self
    }

    // MARK: Object Lifecycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }

    // MARK: Setup

    func commonInit() {
        addSubview(titleLabel)
        addSubview(imageView)
        addGestureRecognizer(tapGesture)
        
    }

    // MARK: UIView Overrides

    override func layoutSubviews() {
        super.layoutSubviews()
titleLabelConstraints()
imageViewConstraints()
detailView.frame = imageView.frame
        
    }

    // MARK: Layout
    
    func layoutTitleLabel(event:FBEvents?) {
        titleLabel.text = event?.title
    }
    
    func layoutImageView(eventImage:UIImage?) {
        imageView.image = eventImage
       
    }
    
    func layoutDetailView(from event:FBEvents?) {
        detailView.frame = imageView.frame
        self.detailView.descriptionLabel.text = event?.description?.replacingOccurrences(of: "<em>", with: "").replacingOccurrences(of: "<br>", with: "").replacingOccurrences(of: "</em>", with: "").replacingOccurrences(of: "</br>", with: "")
        
    }

    // MARK: User Actions

    @objc func handleTap(tap: UITapGestureRecognizer) {
        if isDisplayingDetailView {
            hideDetailView()
        } else {
            showDetailView()
        }
    }

    func hideDetailView() {
        UIView.animate(withDuration: 0.25, animations: { [weak self] in
            self?.detailView.alpha = 0
        }) { _ in
            self.detailView.removeFromSuperview()
        }
    }

    func showDetailView() {
        detailView.alpha = 0
        addSubview(detailView)
        UIView.animate(withDuration: 0.25) { [weak self] in
            self?.detailView.alpha = 1
        }
    }

    private func titleLabelConstraints() {
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: self.topAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            titleLabel.heightAnchor.constraint(equalToConstant: self.frame.height * 0.1)
        ])
    }
        
        private func imageViewConstraints() {
            imageView.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                imageView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor,constant: self.frame.height * 0.01),
                imageView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
                imageView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
                imageView.bottomAnchor.constraint(equalTo: self.bottomAnchor,constant: -UIScreen.main.bounds.height * 0.05)
            ])
        
    }
    private func detailViewConstraints() {
        detailView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            detailView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor,constant: self.frame.height * 0.01),
            detailView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            detailView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            detailView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
    }
}
