import UIKit

class SendInviteView: UIView {
    
    //MARK: UI Objects
    
    lazy var userInstructions:UILabel = {
        let uiLabel = UILabel()
        uiLabel.adjustsFontSizeToFitWidth = true
        uiLabel.font = UIFont(name: "Arial-Bold", size: 16)
        uiLabel.numberOfLines = 0
        uiLabel.textAlignment = .center
        uiLabel.text = "Please Enter Your Partner's Email"
        return uiLabel
    }()
    
    lazy var emailField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Pending Invitation"
        textField.borderStyle = .roundedRect
        textField.backgroundColor = .lightText
        return textField
    }()
    
    lazy var enterButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("enter", for: .normal)
        button.setTitleColor(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1), for: .normal)
        button.titleLabel?.font = UIFont(name: "Arial-Bold", size: 16)
        button.backgroundColor = #colorLiteral(red: 0.1345793307, green: 0.03780555353, blue: 0.9968826175, alpha: 1)
        button.layer.cornerRadius = 5
        
        button.isEnabled = true
        return button
    }()
    
    
    public lazy var stackView: UIStackView = {
        
        let sv = UIStackView(arrangedSubviews: [self.userInstructions, self.emailField, self.enterButton])
        
        sv.axis = .vertical
        sv.alignment = .fill
        sv.distribution = .fill
        sv.spacing = 20
        
        return sv
    }()
    
    override init(frame: CGRect) {
        super.init(frame: UIScreen.main.bounds)
        addConstraintsToSelf()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
    }
    
    private func addConstraintsToSelf() {
        backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        addSubview(userInstructions)
        addSubview(emailField)
        addSubview(enterButton)
        addSubview(stackView)
        setUpUserInstructionsConstraints()
        setUpEmailTextFieldConstraints()
        setUpEnterButtonConstraints()
        setUpStackViewConstraints()
    }
    
    private func setUpUserInstructionsConstraints(){
        
        userInstructions.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            userInstructions.heightAnchor.constraint(equalToConstant: self.frame.height * 0.05)
        ])
    }
    
    private func setUpEmailTextFieldConstraints(){
        emailField.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
     
            emailField.heightAnchor.constraint(equalToConstant: self.frame.height * 0.05)
        ])
    }
    
    private func setUpEnterButtonConstraints(){
        enterButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            enterButton.heightAnchor.constraint(equalToConstant: self.frame.height * 0.1)
        ])
    }
    
    private func setUpStackViewConstraints(){
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            
            stackView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: self.frame.height * 0.2),
            stackView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 40),
            stackView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -40),
            
        ])
    }
}




