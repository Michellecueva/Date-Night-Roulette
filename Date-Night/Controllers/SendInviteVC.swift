
import UIKit
import FirebaseAuth

class SendInviteVC: UIViewController {

    let sendInviteView = SendInviteView()
    
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
        addObjcFunctions()
        // Do any additional setup after loading the view.
    }
    
    private func changeStatus() {
      //  leftScreenStatus = .waitingForResponse
        delegate?.changeStatus(status: .waitingForResponse)
        
    }
    
    private func addObjcFunctions() {
        sendInviteView.enterButton.addTarget(self, action: #selector(sendInvite), for: .touchUpInside)
    }
    
  @objc private func sendInvite() {
        
    guard let recipient = sendInviteView.emailField.text else {
            //add alert
            print("could not invite user")
            return
        }
        let invite = Invites(from: currentUserEmail, to: recipient, invitationStatus: .pending)
           
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
