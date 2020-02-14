
import FirebaseAuth
import FirebaseFirestore
import UIKit

class InvitesPendingVC: UIViewController {
    
    var invites: [Invites] = [] {
        didSet {
            createSnapshot(from: invites)
        }
    }
    
    let invitesPendingView = InvitesPendingView()
    
    private var dataSource: UITableViewDiffableDataSource<Section, Invites>!
    
    private var inviteListener: ListenerRegistration?
    
    private let db = Firestore.firestore()
    
    private var currentUserEmail:String {
        if let user = Auth.auth().currentUser?.email {
            return user
        } else {
            return "Invalid Email"
        }
    }
    
    private var collectionReference:CollectionReference {
        return db.collection("invites")
    }
    
    deinit {
        inviteListener?.remove()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(invitesPendingView)
        configureDataSource()
        addListener()
        print(currentUserEmail)
    }
    
    private func configureDataSource() {
        dataSource = UITableViewDiffableDataSource<Section, Invites>(tableView: invitesPendingView.invitesPendingTableView, cellProvider: { (tableView, indexPath, Invite) -> UITableViewCell? in
            let cell = tableView.dequeueReusableCell(withIdentifier: InvitesCell.identifier, for: indexPath) as! InvitesCell
            
            cell.configureCell(with: Invite, row: indexPath.row)
            cell.delegate = self
            return cell
        })
    }
    
    private func createSnapshot(from invites: [Invites]) {
        var snapshot = NSDiffableDataSourceSnapshot<Section, Invites>()
        
        snapshot.appendSections([.main])
        snapshot.appendItems(invites)
        dataSource.apply(snapshot, animatingDifferences: true)
    }
    
    // MARK: Firebase Functions
    
    private func updatePartnerUsernameField(partnerUserName: String?) {
        FirestoreService.manager.updateCurrentUser(partnerUserName: partnerUserName) { (result) in
            switch result {
            case.success():
                print("able to update partner username")
            case .failure(let error):
                print(error)
            }
        }
    }
    
    private func updatePartnersField(partnerUID: String) {
        FirestoreService.manager.updatePartnerUser(partnerUID: partnerUID) { (result) in
            switch result {
            case .success():
                print("Able to update partner's field")
            case .failure(let error):
                print(error)
            }
        }
    }
}

extension InvitesPendingVC {
    
    private func addListener() {
        inviteListener = collectionReference.whereField(
            "to",
            isEqualTo: currentUserEmail
        )
            .addSnapshotListener({ (snapshot, error) in
                
                if let error = error {
                    print(error.localizedDescription)
                }
                guard let invitesFromOnline = snapshot?.documents else {
                    print("no invites available")
                    return
                }
                let inviteList = invitesFromOnline.compactMap { (snapshot) -> Invites? in
                    let inviteID = snapshot.documentID
                    let data = snapshot.data()
                    return Invites(from: data, id: inviteID)
                }
                self.invites = inviteList
                print("inviteList: \(inviteList)")
            })
    }
}

extension InvitesPendingVC: CellDelegate {
    func handleAcceptedInvite(tag: Int) {
        let invite = invites[tag]
        print(invite)
        FirestoreService.manager.updateInvitationStatus(inviteID:invite.id, invitationStatus: invitationStatus.accepted.rawValue) { (result) in
            switch result {
            case .success():
                print("Able to update field")
            case .failure(let error):
                print("Unable to update field: \(error)")
            }
        }
        
        FirestoreService.manager.updateCurrentUser(partnerEmail: invite.from) { (result) in
            switch result {
            case .success():
                print("Able to update user with partner email")
            case .failure(let error):
                print("Unable to update user with partner email \(error)")
            }
        }
        
        FirestoreService.manager.getPartnersUserData(partnerEmailAddress: invite.from) { (result) in
            switch result {
            case .success(let users):
                print(users[0])
                
                let partner = users[0]
                
                self.updatePartnerUsernameField(partnerUserName: partner.firstName)
                self.updatePartnersField(partnerUID: partner.uid)
                
                // once we have user object we need to get that first name and update current user's field
                //we have to update partner user object with current users first name and email which is the dipslay name for currentuser
            case .failure(let error):
                print("unable to get partner user data \(error)")
            }
        }
        
        //update currentUsers doc with partnerEmail
        //find user's partners doc by making a quiery where it gets you back the user doc where the email in the invites from field equals the email in the user doc. Once you get that User object get the id to update the user's partners doc with the current user's email.
        //remove all Invites that are pending
    }
    
    func handleDeclinedInvite(tag: Int) {
        let invite = invites[tag]
      
        FirestoreService.manager.removeInvite(invite: invite) { (result) in
            switch result {
            case .success():
                print("removed succesfully")
                let indexOfCurrentInvite = self.invites.firstIndex { $0.id == invite.id}
                guard let index = indexOfCurrentInvite else {return}
                self.invites.remove(at: index)
            case .failure(let error):
                print("Failed at removing Invite: \(error)")
            }
        }
    }
}

extension InvitesPendingVC {
    fileprivate enum Section {
        case main
    }
}
