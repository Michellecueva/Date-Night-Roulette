//
//  EventCardDetailView.swift
//  EventView
//
//  Created by Phoenix McKnight on 3/12/20.
//  Copyright © 2020 Phoenix McKnight. All rights reserved.
//

import UIKit

class EventCardDetailView: UIView {

    let scrollView = UIScrollView()
    let descriptionLabel = UILabel()

    // MARK: Object Lifecycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }

    func commonInit() {
        addSubview(scrollView)
        scrollView.addSubview(descriptionLabel)
        descriptionLabel.numberOfLines = 0
        descriptionLabel.textColor = .white
        backgroundColor = UIColor.black.withAlphaComponent(0.70)
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        scrollView.frame = bounds
        let fittingSize =
            CGSize(width: frame.width, height: CGFloat.greatestFiniteMagnitude)
        let descriptionLabelSize = descriptionLabel.sizeThatFits(fittingSize)
        descriptionLabel.frame = CGRect(x: 0, y: 0, width: descriptionLabelSize.width, height: descriptionLabelSize.height)
        scrollView.contentSize = descriptionLabelSize
    }
}
