

import UIKit



class ShakeGestureView: UIView {
    
    
    lazy var shakeLabel: UILabel = {
        let label1 = UILabel()
        label1.textColor = #colorLiteral(red: 0.9164920449, green: 0.7743749022, blue: 0.9852260947, alpha: 1)
        label1.text = "Shake for\nnext experience"
        label1.numberOfLines = 0
        label1.textAlignment = .center
        label1.adjustsFontForContentSizeCategory = true
        label1.font = UIFont(name: "CopperPlate", size: 40)
        return label1
    }()
    
    lazy var shakeEventView: ShakeEventView = {
        let daView = ShakeEventView()
        daView.backgroundColor = .brown
        return daView
    }()
    
    
    lazy var confirmButton: UIButton = {
        let button = UIButton()
        button.setTitle("It's a date!", for: .normal)
        button.setTitleColor(#colorLiteral(red: 1, green: 0.329310298, blue: 0.9998843074, alpha: 1), for: .normal)
        button.setTitleColor(#colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1), for: .disabled)
        button.titleLabel?.font = UIFont(name: "Copperplate", size: 20)
        button.layer.borderColor = #colorLiteral(red: 0.9164920449, green: 0.7743749022, blue: 0.9852260947, alpha: 1)
//            colorLiteral(red: 0.9092509151, green: 0.7310814261, blue: 1, alpha: 1)
        button.layer.cornerRadius = 5
        button.layer.borderWidth = 2
        button.isEnabled = true
        return button
    }()
    
    /*
     lazy var logoutButton: UIButton = {
       let button = UIButton(type: .system)
       button.setTitle("Logout", for: .normal)
       button.setTitleColor(colorLiteral(red: 0.9534531236, green: 0.3136326671, blue: 1, alpha: 1), for: .normal)
       button.titleLabel?.font = UIFont(name: "CopperPlate", size: 20)
       button.layer.borderColor = colorLiteral(red: 0.9092509151, green: 0.7310814261, blue: 1, alpha: 1)
       button.layer.borderWidth = 2
       button.layer.cornerRadius = 5
       button.isEnabled = true
       return button
     }()
     */
    
    
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

