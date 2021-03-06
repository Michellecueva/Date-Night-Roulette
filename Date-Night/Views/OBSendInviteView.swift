import UIKit

class OBSendInviteView: UIView {
    
    //MARK: UI Objects
    
    
    lazy var inviteLabel: UILabel = {
        let label1 = UILabel()
        label1.textColor = StyleGuide.TitleFontStyle.fontColor
        label1.text = "Invite your partner"
        label1.numberOfLines = 0
        label1.textAlignment = .center
        label1.textColor = .white
        label1.adjustsFontForContentSizeCategory = true
        label1.font = UIFont(name:StyleGuide.TitleFontStyle.fontName, size:StyleGuide.FontStyle.altFontSize)
        return label1
    }()
    
    lazy var userInstructions:UILabel = {
        let uiLabel = UILabel()
        uiLabel.adjustsFontSizeToFitWidth = true
        uiLabel.font = UIFont(name: StyleGuide.FontStyle.fontName, size: StyleGuide.FontStyle.fontSize)
        uiLabel.numberOfLines = 0
        uiLabel.textAlignment = .center
        uiLabel.textColor = StyleGuide.FontStyle.fontColor
        uiLabel.text = "Please enter your partners email to have them join you on the app!"
        return uiLabel
    }()
    
    lazy var emailField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Email Address"
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

    lazy var skipButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Skip", for: .normal)
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
        
        let sv = UIStackView(arrangedSubviews: [self.inviteLabel, self.userInstructions, self.emailField, self.enterButton, self.skipButton])
        
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
        backgroundColor = StyleGuide.AppColors.backgroundColor
        addSubview(inviteLabel)
        addSubview(userInstructions)
        addSubview(emailField)
        addSubview(enterButton)
        addSubview(skipButton)
        addSubview(stackView)
        setUpInviteLabelConstraints()
        setUpUserInstructionsConstraints()
        setUpEmailTextFieldConstraints()
        setUpEnterButtonConstraints()
        setUpSkipButtonConstraints()
        setUpStackViewConstraints()
    }
    
    private func setUpInviteLabelConstraints(){
           
           inviteLabel.translatesAutoresizingMaskIntoConstraints = false
           
           NSLayoutConstraint.activate([
               inviteLabel.heightAnchor.constraint(equalToConstant: self.frame.height * 0.05)
           ])
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
            enterButton.heightAnchor.constraint(equalToConstant: self.frame.height * 0.05)
        ])
    }
    private func setUpSkipButtonConstraints(){
        skipButton.translatesAutoresizingMaskIntoConstraints = false
               
        NSLayoutConstraint.activate([
            skipButton.heightAnchor.constraint(equalToConstant: self.frame.height * 0.05)
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




