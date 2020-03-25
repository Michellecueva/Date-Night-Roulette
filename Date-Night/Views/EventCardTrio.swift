//
//  EventCardTrio.swift
//  EventView
//
//  Created by Phoenix McKnight on 3/24/20.
//  Copyright © 2020 Phoenix McKnight. All rights reserved.
//

import UIKit

class EventCardTrio: UIView {

    let eventCardOne = EventCard()
    let eventCardTwo = EventCard()
    let eventCardThree = EventCard()
    
    var firstCard:EventCard? {
        didSet {
            UIView.animate(withDuration: 0.2) { [weak self] in
                self?.firstCard?.transform = .identity
        }
        }
    }
    var secondCard:EventCard? {
        didSet {
            UIView.animate(withDuration: 0.2) { [weak self] in
                self?.secondCard?.transform = CGAffineTransform(translationX: 0, y: (self?.frame.height ?? 0) * 0.05)
            }
        }
    }
    var thirdCard:EventCard? {
        didSet {
            UIView.animate(withDuration: 0.2) { [weak self] in
                
                self?.thirdCard?.transform = CGAffineTransform(translationX: 0, y: (self?.frame.height ?? 0) * 0.10)
              }
        }
    }
   
    lazy var trio = [self.eventCardOne,self.eventCardTwo,self.eventCardThree]
    override init(frame: CGRect) {
        super.init(frame: UIScreen.main.bounds)
        commonInit()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    private func commonInit() {
        self.addSubview(eventCardThree)
        self.addSubview(eventCardTwo)
        self.addSubview(eventCardOne)
      
      
        eventConstraints()
        initialCardSetup()
        
    }
    
    private func initialCardSetup() {
        firstCard = eventCardOne
        secondCard = eventCardTwo
        thirdCard = eventCardThree
    }
    
    private func eventConstraints() {

        eventCardOne.translatesAutoresizingMaskIntoConstraints = false
        eventCardTwo.translatesAutoresizingMaskIntoConstraints = false
        eventCardThree.translatesAutoresizingMaskIntoConstraints = false
              NSLayoutConstraint.activate([
              eventCardOne.centerXAnchor.constraint(equalTo: self.centerXAnchor),
              eventCardOne.centerYAnchor.constraint(equalTo: self.centerYAnchor),
              eventCardOne.heightAnchor.constraint(equalToConstant: self.frame.width * 0.8),
                  eventCardOne.widthAnchor.constraint(equalToConstant: self.frame.height * 0.5),
                  eventCardTwo.centerXAnchor.constraint(equalTo: self.centerXAnchor),
                  eventCardTwo.centerYAnchor.constraint(equalTo: self.centerYAnchor),
                  eventCardTwo.heightAnchor.constraint(equalToConstant: self.frame.width * 0.8),
                      eventCardTwo.widthAnchor.constraint(equalToConstant: self.frame.height * 0.5),
                      eventCardThree.centerXAnchor.constraint(equalTo: self.centerXAnchor),
                      eventCardThree.centerYAnchor.constraint(equalTo: self.centerYAnchor),
                      eventCardThree.heightAnchor.constraint(equalToConstant: self.frame.width * 0.8),
                          eventCardThree.widthAnchor.constraint(equalToConstant: self.frame.height * 0.5)
              ])
    }
}
