
import UIKit

class ShakeGestureView: UIView {
    
    lazy var shakeLabel: UILabel = {
        let label1 = UILabel()
        label1.textColor = StyleGuide.TitleFontStyle.fontColor
        label1.text = "Shake for\nNext Experience"
        label1.numberOfLines = 0
        label1.textAlignment = .center
        label1.adjustsFontForContentSizeCategory = true
        label1.font = UIFont(name:StyleGuide.TitleFontStyle.fontName, size:StyleGuide.TitleFontStyle.fontSize)
        return label1
    }()
    
    lazy var shakeEventView: ShakeEventView = {
        let daView = ShakeEventView()
        daView.backgroundColor = .brown
        return daView
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
        
    }
    
    private func addShakeSubviews() {
        self.addSubview(shakeLabel)
        //        self.addSubview(shakeCollectionView)
        self.addSubview(shakeEventView)
        self.addSubview(confirmButton)
        
    }
    
    private func setShakeConstraints() {
        setShakeLabelConstraints()
        //        setShakeCollectionConstraints()
        setShakeEventViewConstraints()
        setConfirmButtonConstraints()
    }
    
    private func setShakeLabelConstraints() {
        shakeLabel.translatesAutoresizingMaskIntoConstraints = false
        shakeLabel.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 60).isActive = true
        shakeLabel.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 40).isActive = true
        shakeLabel.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -40).isActive = true
        shakeLabel.heightAnchor.constraint(equalToConstant: 90).isActive = true
    }
    
    private func setShakeEventViewConstraints() {
        shakeEventView.translatesAutoresizingMaskIntoConstraints = false
        shakeEventView.topAnchor.constraint(equalTo: self.shakeLabel.bottomAnchor, constant: 30).isActive = true
        shakeEventView.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor).isActive = true
        shakeEventView.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor).isActive = true
        shakeEventView.heightAnchor.constraint(equalToConstant: self.frame.height * 0.46).isActive = true
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

