
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
    
    lazy var eventCard: EventCard = {
        let eventView = EventCard()
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
        displayEventLabel.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: self.frame.height * 0.1).isActive = true
        displayEventLabel.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 40).isActive = true
        displayEventLabel.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -40).isActive = true
        displayEventLabel.heightAnchor.constraint(equalToConstant: 90).isActive = true
    }
    
    private func seteventCardConstraints() {
        eventCard.translatesAutoresizingMaskIntoConstraints = false
        eventCard.centerYAnchor.constraint(equalTo: self.centerYAnchor,constant: self.frame.height * 0.05).isActive = true
        eventCard.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        eventCard.widthAnchor.constraint(equalTo:self.widthAnchor).isActive = true
        eventCard.heightAnchor.constraint(equalToConstant: self.frame.height * 0.46).isActive = true
    }
    
    private func setConfirmButtonConstraints() {
        confirmButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            confirmButton.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -150),
            confirmButton.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            confirmButton.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.5),
            confirmButton.heightAnchor.constraint(equalToConstant: 30)
        ])
    }
    
}

