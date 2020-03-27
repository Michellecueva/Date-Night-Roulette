
import UIKit

class DisplayEventView: UIView {
    
    lazy var displayEventLabel: UILabel = {
        let label1 = UILabel()
        label1.textColor = StyleGuide.TitleFontStyle.fontColor
        label1.text = "Swipe Right to like, \nSwipe left to dislike "
        label1.numberOfLines = 0
        label1.textAlignment = .center
        label1.textColor = .white
        label1.adjustsFontForContentSizeCategory = true
        label1.font = UIFont(name:StyleGuide.TitleFontStyle.fontName, size:StyleGuide.TitleFontStyle.altFontSize)
        return label1
    }()
    
    lazy var eventCard: EventCardTrio = {
        let eventView = EventCardTrio()
        return eventView
    }()
    
    
    lazy var confirmButton: UIButton = {
        let button = UIButton()
        button.setTitle("It's a Date!", for: .normal)
        button.setTitleColor(StyleGuide.ButtonStyle.fontColor, for: .normal)
        button.setTitleColor(StyleGuide.ButtonStyle.disabledColor, for: .disabled)
        button.titleLabel?.font = UIFont(name: StyleGuide.ButtonStyle.fontName, size: StyleGuide.ButtonStyle.fontSize)
        button.backgroundColor = StyleGuide.ButtonStyle.backgroundColor
        button.layer.cornerRadius = StyleGuide.ButtonStyle.cornerRadius
        button.layer.borderColor = StyleGuide.ButtonStyle.borderColor
        button.layer.borderWidth = StyleGuide.ButtonStyle.borderWidth
        button.isEnabled = true
        return button
    }()
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(frame: CGRect) {
        super.init(frame: UIScreen.main.bounds)
        addShakeSubviews()
        setShakeConstraints()
        self.backgroundColor = StyleGuide.AppColors.backgroundColor
        
    }
    
    private func addShakeSubviews() {
        self.addSubview(displayEventLabel)
        //        self.addSubview(shakeCollectionView)
        self.addSubview(eventCard)
        self.addSubview(confirmButton)
        
    }
    
    private func setShakeConstraints() {
        setShakeLabelConstraints()
        seteventCardConstraints()
        setConfirmButtonConstraints()
    }
    
    private func setShakeLabelConstraints() {
        displayEventLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
         displayEventLabel.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: self.frame.height * 0.05),
         displayEventLabel.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: self.frame.width * 0.1),
            displayEventLabel.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -self.frame.width * 0.1),
            displayEventLabel.heightAnchor.constraint(equalToConstant: self.frame.height * 0.1)
         
        ])

    }
    
    private func seteventCardConstraints() {
        eventCard.translatesAutoresizingMaskIntoConstraints = false
       
        NSLayoutConstraint.activate([
            eventCard.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            eventCard.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            eventCard.leadingAnchor.constraint(equalTo: self.leadingAnchor,constant: 0),
            eventCard.trailingAnchor.constraint(equalTo: self.trailingAnchor,constant: 0),
            eventCard.heightAnchor.constraint(equalToConstant: self.frame.height * 0.45)
        ])
    }
    
    private func setConfirmButtonConstraints() {
        confirmButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            confirmButton.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -self.frame.height * 0.15),
                      confirmButton.centerXAnchor.constraint(equalTo: self.centerXAnchor),
                      confirmButton.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.5),
                      confirmButton.heightAnchor.constraint(equalToConstant: self.frame.height * 0.05)
                    
        ])
    }
    
}

