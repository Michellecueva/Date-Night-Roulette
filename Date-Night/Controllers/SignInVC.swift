
import UIKit

class SignInVC: UIViewController {
    
    let viewSignIn = SignInView()
    
    var scrollView = UIScrollView(frame: UIScreen.main.bounds)
    
    lazy var bottomScrollConstraint: NSLayoutConstraint = {
           scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
    }()
    
  
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(scrollView)
        addObjcFunctionsToViewObjects()
        addKeyboardAppearObserver()
        addKeyboardDismissObserver()
        setScrollView()
        setDelegate()
    }
    
    override func viewWillLayoutSubviews() {
          super.viewWillLayoutSubviews()
          setUpScrollView()
      }
    
    private func setDelegate() {
        viewSignIn.emailField.delegate = self
        viewSignIn.passwordField.delegate = self
    }
    
    private func setScrollView() {
        self.scrollView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.scrollView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            self.scrollView.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 20),
            self.scrollView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            bottomScrollConstraint
        ])
    }
    
    private func addKeyboardAppearObserver()
    {
        NotificationCenter.default.addObserver(self, selector: #selector(handleKeyboardAppearing(sender:)), name: UIResponder.keyboardWillShowNotification,
                                               object: nil)
    }
    
    private func addKeyboardDismissObserver()
    {
        NotificationCenter.default.addObserver(self, selector: #selector(handleKeyboardDisappearing(sender:)), name: UIResponder.keyboardWillHideNotification,
                                               object: nil)
    }
    
    private func adjustInsetForKeyboardShow(_ show: Bool, notification: Notification) {
          guard
            let userInfo = notification.userInfo,
            let keyboardFrame = userInfo[UIResponder.keyboardFrameEndUserInfoKey]
              as? NSValue
            else {
              return
          }
        
        // commented code makes this screen work as intended in conjunction with adjusting height code below
        
//        if notification.name == UIResponder.keyboardWillHideNotification{
//            scrollView.setContentOffset(.zero, animated: true)
//        } else {
//           let scrollPoint = CGPoint(x: 0.0, y: self.viewSignIn.loginButton.frame.origin.y - (keyboardFrame.cgRectValue.height) - view.frame.height * 0.05)
//
//           scrollView.setContentOffset(scrollPoint, animated: true)
//        }
//
          let adjustmentHeight = (keyboardFrame.cgRectValue.height + 20) * (show ? 3 : -3)
          scrollView.contentInset.bottom += adjustmentHeight
          scrollView.verticalScrollIndicatorInsets.bottom += adjustmentHeight
    }
    
    @objc func handleKeyboardAppearing(sender: Notification) {
        adjustInsetForKeyboardShow(true, notification: sender)
    }
    
    @objc func handleKeyboardDisappearing(sender: Notification) {
        adjustInsetForKeyboardShow(false, notification: sender)
        
    }
    
    @objc private func loginButton() {
        loginButtonFunctions(email:viewSignIn.emailField.text,password:viewSignIn.passwordField.text)
    }
    
    @objc private func createAccountButton() {
        createAccount()
    }
    
    private func addObjcFunctionsToViewObjects() {
        viewSignIn.loginButton.addTarget(self, action: #selector(loginButton), for: .touchUpInside)
        viewSignIn.createAccountButton.addTarget(self, action: #selector(createAccountButton), for: .touchUpInside)
    }
    
    private func createAccount() {
        let signupVC = SignUpVC()
        signupVC.modalPresentationStyle = .formSheet
        present(signupVC, animated: true, completion: nil)
    }
    
    private func loginButtonFunctions(email:String?,password:String?) {
        
        guard let email = email, let password = password else {
            //add alert
            return
        }
        
        guard email.isValidEmail else {
            //add alert
            return
        }
        
        guard password.isValidPassword else {
            //add alert
            return
        }
        FirebaseAuthService.manager.loginUser(email: email.lowercased().trimmingCharacters(in: .whitespacesAndNewlines), password: password) { (result) in
            self.handleLoginResponse(vc: UINavigationController(rootViewController:RootViewController()), with: result)
        }
    }
    private func handleLoginResponse(vc:UINavigationController, with result: Result<(), AppError>) {
        switch result {
            
        case .success:
            guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
                let sceneDelegate = windowScene.delegate as? SceneDelegate, let window = sceneDelegate.window
                else {
                    return
            }
            
            UIView.transition(with: window, duration: 0.3, options: .transitionFlipFromBottom, animations: {
                if FirebaseAuthService.manager.currentUser != nil {
                    window.rootViewController = vc
                } else {
                    print("No current user")
                }
            }, completion: nil)
        case .failure(let error):
            print(error)
            //add alert
        }
    }
    
    private func setUpScrollView() {
        scrollView.addSubview(viewSignIn)
        scrollView.alwaysBounceVertical = false
        view.addSubview(scrollView)
        scrollView.delegate = self
    }
}

extension SignInVC: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}

extension SignInVC: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
       
    }
}





