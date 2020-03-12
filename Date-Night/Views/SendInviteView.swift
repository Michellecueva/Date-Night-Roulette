import UIKit

class SendInviteView: UIView {
    
    //MARK: UI Objects
    
    lazy var userInstructions:UILabel = {
        let uiLabel = UILabel()
        uiLabel.adjustsFontSizeToFitWidth = true
        uiLabel.font = UIFont(name: StyleGuide.FontStyle.fontName, size: StyleGuide.FontStyle.fontSize)
        uiLabel.numberOfLines = 0
        uiLabel.textAlignment = .center
        uiLabel.textColor = StyleGuide.FontStyle.fontColor
        uiLabel.text = "Please Enter Your Partner's Email"
        return uiLabel
    }()
    
    lazy var emailField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Enter Partners Email"
        textField.font = UIFont(name: StyleGuide.TextFieldStyle.fontName, size: StyleGuide.TextFieldStyle.fontSize)
        textField.backgroundColor = StyleGuide.TextFieldStyle.backgroundColor
        textField.borderStyle = .roundedRect
        textField.backgroundColor = StyleGuide.TextFieldStyle.backgroundColor
        return textField
    }()
    
    
    lazy var enterButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Send Invite", for: .normal)
        button.setTitleColor(StyleGuide.ButtonStyle.fontColor, for: .normal)
        button.titleLabel?.font = UIFont(name: StyleGuide.ButtonStyle.fontName, size: StyleGuide.ButtonStyle.fontSize)
        button.backgroundColor = StyleGuide.ButtonStyle.backgroundColor
        button.layer.cornerRadius = StyleGuide.ButtonStyle.cornerRadius
        button.layer.borderColor = StyleGuide.ButtonStyle.borderColor
        button.layer.borderWidth = StyleGuide.ButtonStyle.borderWidth
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
        backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
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




