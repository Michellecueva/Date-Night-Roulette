import UIKit

class WaitingForResponseView: UIView {

    lazy var waitingStatusLabel: UILabel = {
        let label = UILabel()
        label.text = "Waiting for response to..."
        label.textColor = #colorLiteral(red: 0.9092509151, green: 0.7310814261, blue: 1, alpha: 1)
        label.textAlignment = .center
        label.adjustsFontSizeToFitWidth = true
        label.font = UIFont(name: "Palatino-bold", size: 25)
        return label
    }()
    
    lazy var partnerPortraitPic: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(systemName: "person.crop.circle.badge.plus")
        return image
    }()

    
    lazy var pendingPartner: UILabel = {
        let label = UILabel()
        label.text = "PartnerName"
        label.textAlignment = .center
        label.font = UIFont(name: "Palatino-bold", size: 25)
        label.textColor = #colorLiteral(red: 0.9092509151, green: 0.7310814261, blue: 1, alpha: 1)
        return label
    }()
    
    lazy var cancelButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Cancel", for: .normal)
        button.setTitleColor(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 1), for: .normal)
        button.backgroundColor = #colorLiteral(red: 0.9092509151, green: 0.7310814261, blue: 1, alpha: 1)
        button.titleLabel?.font = UIFont(name: "Arial", size: 20)
        button.layer.cornerRadius = 5
        button.isEnabled = true
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: UIScreen.main.bounds)
        self.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        setSubviews()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setSubviews() {
        self.addSubview(waitingStatusLabel)
        self.addSubview(pendingPartner)
        self.addSubview(partnerPortraitPic)
        self.addSubview(cancelButton)
    }
    
    
    private func setConstraints() {
        setPendingStatusConstraint()
        setPartnerPortraitConstraints()
        setPendingPartnerConstraint()
        setCancelButtonConstraints()
    }
    
    private func setPendingStatusConstraint() {
        waitingStatusLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            waitingStatusLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: self.frame.height * 0.20),
            waitingStatusLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            waitingStatusLabel.widthAnchor.constraint(equalToConstant: 300),
            waitingStatusLabel.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
    
    private func setPartnerPortraitConstraints() {
        partnerPortraitPic.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            partnerPortraitPic.topAnchor.constraint(equalTo: waitingStatusLabel.bottomAnchor, constant: 40),
            partnerPortraitPic.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            partnerPortraitPic.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.5),
            partnerPortraitPic.heightAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.4)
        ])
    }
    
    private func setPendingPartnerConstraint() {
        pendingPartner.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            pendingPartner.topAnchor.constraint(equalTo: partnerPortraitPic.bottomAnchor, constant: 20),
            pendingPartner.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            pendingPartner.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.5),
            pendingPartner.heightAnchor.constraint(equalToConstant: 40)
        
        ])
    }
    
    private func setCancelButtonConstraints() {
        cancelButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            cancelButton.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -50),
            cancelButton.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            cancelButton.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.30),
            cancelButton.heightAnchor.constraint(equalToConstant: 30)
        ])
    }
    
    
}
