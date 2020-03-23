
import UIKit

class SignInVC: UIViewController {
    
    let viewSignIn = SignInView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(viewSignIn)
        addObjcFunctionsToViewObjects()
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
            self.showAlert(title: "Error", message: "Invalid Email / Password")
            return
        }
        
        guard email.isValidEmail else {
            self.showAlert(title: "Error", message: "This Email Address is Not Associated With an Account")
            return
        }
        
        guard password.isValidPassword else {
            self.showAlert(title: "Error", message: "This Password is Incorrect")
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
}

