import UIKit

class EventCardTrio: UIView {


    lazy var eventCardOne:EventCard = {
    let event = EventCard()
        event.layer.setCustomLayer(radius: 5)
        return event
    }()
    
     lazy var eventCardTwo:EventCard = {
     let event = EventCard()
         event.layer.setCustomLayer(radius: 5)
         return event
     }()
    
     lazy var eventCardThree:EventCard = {
     let event = EventCard()
         event.layer.setCustomLayer(radius: 5)
         return event
     }()
    
    var firstCard:EventCard? {
        didSet {
            UIView.animate(withDuration: 0.2) { [weak self] in
                self?.firstCard?.transform = .identity
                self?.firstCard?.titleLabel.alpha = 1.0
                self?.firstCard?.imageView.isOpaque = true
                self?.firstCard?.layer.borderColor = StyleGuide.AppColors.primaryColor.cgColor
            }
        }
    }
    var secondCard:EventCard? {
        didSet {
            secondCard?.titleLabel.alpha = 0.0
            secondCard?.imageView.isOpaque = false
            UIView.animate(withDuration: 0.2) { [weak self] in
                self?.secondCard?.transform = CGAffineTransform(translationX: 1, y: (self?.frame.height ?? 0) * 0.05).scaledBy(x: 0.9, y: 1.0)
              self?.secondCard?.layer.borderColor = StyleGuide.AppColors.primaryColor.cgColor

            }
        }
    }
    var thirdCard:EventCard? {
        didSet {
            thirdCard?.titleLabel.alpha = 0.0
            thirdCard?.imageView.isOpaque = false
            UIView.animate(withDuration: 0.2) { [weak self] in
                
                self?.thirdCard?.transform = CGAffineTransform(translationX: 1, y: (self?.frame.height ?? 0) * 0.10).scaledBy(x: 0.8, y: 1.0)
                self?.thirdCard?.layer.borderColor = StyleGuide.AppColors.primaryColor.cgColor
              }
        }
    }
   
  lazy var queue = [self.eventCardOne,self.eventCardTwo,self.eventCardThree]
    
    override init(frame: CGRect) {
        super.init(frame: UIScreen.main.bounds)
        commonInit()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    private func commonInit() {
        addSubviews()
        eventCardOneConstraints()
        eventCardTwoConstraints()
        eventCardThreeConstraints()
        initialCardSetup()
        changeBackgroundColors()
    }
    
    private func addSubviews() {
               self.addSubview(eventCardThree)
               self.addSubview(eventCardTwo)
               self.addSubview(eventCardOne)
    }
    private func changeBackgroundColors() {
        eventCardOne.backgroundColor = StyleGuide.AppColors.backgroundColor
        eventCardTwo.backgroundColor = StyleGuide.AppColors.backgroundColor
        eventCardThree.backgroundColor = StyleGuide.AppColors.backgroundColor
       

        
    }
    
    private func initialCardSetup() {
        firstCard = eventCardOne
        secondCard = eventCardTwo
        thirdCard = eventCardThree
    }
    
    private func eventCardOneConstraints() {
        eventCardOne.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
           eventCardOne.topAnchor.constraint(equalTo: self.topAnchor),
                 eventCardOne.bottomAnchor.constraint(equalTo: self.bottomAnchor),
                  eventCardOne.leadingAnchor.constraint(equalTo: self.leadingAnchor),
                   eventCardOne.trailingAnchor.constraint(equalTo: self.trailingAnchor),
        ])
    }
    
    private func eventCardTwoConstraints() {
        eventCardTwo.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
               eventCardTwo.topAnchor.constraint(equalTo: self.topAnchor),
                        eventCardTwo.bottomAnchor.constraint(equalTo: self.bottomAnchor),
                         eventCardTwo.leadingAnchor.constraint(equalTo: self.leadingAnchor),
                          eventCardTwo.trailingAnchor.constraint(equalTo: self.trailingAnchor),
               ])

    }
    private func eventCardThreeConstraints() {
        eventCardThree.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
               
            eventCardThree.topAnchor.constraint(equalTo: self.topAnchor),
             eventCardThree.bottomAnchor.constraint(equalTo: self.bottomAnchor),
              eventCardThree.leadingAnchor.constraint(equalTo: self.leadingAnchor),
               eventCardThree.trailingAnchor.constraint(equalTo: self.trailingAnchor),
               ])

    }
    
    

}
