
import UIKit

class WaitingForResponseView: UIView {

    lazy var waitingStatusLabel: UILabel = {
        let label = UILabel()
        label.text = "Awaiting partner's response to invite."
        label.numberOfLines = 2
        label.textColor = StyleGuide.TitleFontStyle.fontColor
        label.textAlignment = .center
        label.adjustsFontSizeToFitWidth = true
        label.font = UIFont(name: StyleGuide.TitleFontStyle.fontName, size: StyleGuide.TitleFontStyle.altFontSize)
        return label
    }()
    
    lazy var unsendButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Remove Invite Sent", for: .normal)
        button.setTitleColor(StyleGuide.ButtonStyle.fontColor, for: .normal)
        button.backgroundColor = StyleGuide.ButtonStyle.backgroundColor
        button.titleLabel?.font = UIFont(name: StyleGuide.ButtonStyle.fontName, size: StyleGuide.ButtonStyle.fontSize)
        button.layer.cornerRadius = StyleGuide.ButtonStyle.cornerRadius
        button.layer.borderColor = StyleGuide.ButtonStyle.borderColor
        button.layer.borderWidth = StyleGuide.ButtonStyle.altBorderWidth
        
        button.isEnabled = true
        return button
    }()
  
    override init(frame: CGRect) {
        super.init(frame: UIScreen.main.bounds)
        self.backgroundColor = StyleGuide.AppColors.backgroundColor
        setSubviews()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setSubviews() {
        self.addSubview(waitingStatusLabel)
        self.addSubview(unsendButton)
    }
    
    
    private func setConstraints() {
        setPendingStatusConstraint()
        unsentButtonConstraints()
    }
    
    private func setPendingStatusConstraint() {
        waitingStatusLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            waitingStatusLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: self.frame.height * 0.50),
            waitingStatusLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            waitingStatusLabel.widthAnchor.constraint(equalToConstant: 300),
            waitingStatusLabel.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
    
    private func unsentButtonConstraints() {
        unsendButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            unsendButton.topAnchor.constraint(equalTo: waitingStatusLabel.bottomAnchor, constant: 30),
            unsendButton.centerXAnchor.constraint(equalTo: waitingStatusLabel.centerXAnchor),
            unsendButton.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.70),
            unsendButton.heightAnchor.constraint(equalToConstant: 30)
        ])
    }
}
