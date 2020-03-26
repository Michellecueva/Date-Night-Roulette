
import UIKit
import FirebaseAuth

class OBSendInviteVC: UIViewController {
    
    let sendInviteView = OBSendInviteView()
    
    weak var delegate:SendInviteDelegate?
    
    //  private var leftScreenStatus:LeftScreenStatus = .sendInvite
    
    private var currentUserEmail:String {
        if let user = Auth.auth().currentUser?.email {
            return user
        } else {
            return "Invalid Email"
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(sendInviteView)
        //setupScene()
        addObjcFunctions()
        
        // Do any additional setup after loading the view.
    }
    
    private func setupScene(){
        
        self.navigationController?.navigationBar.topItem?.title = "Date Night Roulette"
       // navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Skip", style: .plain, target: self, action: #selector(skipButton))
        self.navigationController?.navigationBar.barTintColor = .gray
        navigationItem.rightBarButtonItem?.tintColor = #colorLiteral(red: 0.9712318778, green: 0.9606906772, blue: 0.6410447955, alpha: 1)
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.init(red: 0.9712318778, green: 0.9606906772, blue: 0.6410447955, alpha: 1)]
    }
    
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        sendInviteView.emailField.text = ""
    }
    
    private func changeStatus() {
        //  leftScreenStatus = .waitingForResponse
        delegate?.changeStatus(status: .waitingForResponse)
        
    }
    
    private func addObjcFunctions() {
        sendInviteView.enterButton.addTarget(self, action: #selector(sendInvite), for: .touchUpInside)
        sendInviteView.skipButton.addTarget(self, action: #selector(skipButton), for: .touchUpInside)
    }
    
    
    @objc private func skipButton(){
        present(NoPartnerVC(), animated: true, completion: nil)
       
    }
    
    @objc private func sendInvite() {
        
        guard let recipient = sendInviteView.emailField.text else {
            //add alert
            print("could not invite user")
            return
        }
        let invite = Invites(from: currentUserEmail.lowercased(), to: recipient.lowercased(), invitationStatus: .pending)
        
        FirestoreService.manager.sendInvite(invite: invite) { [weak self] (result) in
            switch result {
            case .failure(let error):
                print(error)
                
            case .success():
                //     self?.showAlert(title: "Success!", message: "Invited \(recipient)")
                print("Invite was succesfully sent")
                self?.changeStatus()
                
            }
        }
    }
}
