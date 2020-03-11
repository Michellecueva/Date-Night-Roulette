
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
    
    private var dataSource: UITableViewDiffableDataSource<Section,Invites>!
    
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
        self.invitesPendingView.invitesPendingTableView.delegate = self
        print(currentUserEmail)
    }
    
    private func configureDataSource() {
        dataSource = UITableViewDiffableDataSource<Section,Invites>(tableView: invitesPendingView.invitesPendingTableView, cellProvider: { (tableView, indexPath, Invite) -> UITableViewCell? in
            let cell = tableView.dequeueReusableCell(withIdentifier: InvitesCell.identifier, for: indexPath) as! InvitesCell
            
            cell.configureCell(with: Invite, row: indexPath.row)
            cell.delegate = self
            return cell
        })
    }
    
    private func createSnapshot(from invites: [Invites]) {
        var snapshot = NSDiffableDataSourceSnapshot<Section, Invites>()
        
        snapshot.appendSections([.invites])
        snapshot.appendItems(invites)
        dataSource.apply(snapshot, animatingDifferences: true)
    }
    
    // MARK: Firebase Functions
    
    private func updateInvitationStatus(inviteID: String) {
        FirestoreService.manager.updateInvitationStatus(inviteID:inviteID, invitationStatus: invitationStatus.accepted.rawValue) { (result) in
            switch result {
            case .success():
                print("Able to update field")
            case .failure(let error):
                print("Unable to update field: \(error)")
            }
        }
    }
    
    private func handleRemoveInvitesFromUser(result:Result<(),AppError>) -> () {
        switch result {
        case .success():
            print("successfully removed partner's invitations")
        case .failure(let error):
            print(error)
        }
    }
    
    private func updatePartnerUsernameAndCoupleID(partnerUserName: String?, coupleID: String?) {
        FirestoreService.manager.updateCurrentUser(partnerUserName: partnerUserName, coupleID: coupleID) { (result) in
            switch result {
            case.success():
                print("able to update partner username")
            case .failure(let error):
                print(error)
            }
        }
    }
    
    private func updatePartnerEmailField(partnerEmail: String) {
        FirestoreService.manager.updateCurrentUser(partnerEmail: partnerEmail) { (result) in
            switch result {
            case .success():
                print("Able to update user with partner email")
            case .failure(let error):
                print("Unable to update user with partner email \(error)")
            }
        }
    }
    
    private func updatePartnersField(partnerUID: String, coupleID: String) {
        FirestoreService.manager.updatePartnerUser(partnerUID: partnerUID, coupleID: coupleID) { (result) in
            switch result {
            case .success():
                print("Able to update partner's field")
            case .failure(let error):
                print(error)
            }
        }
    }
    
    private func getPartnerUserData(partnerEmailAddress: String) {
        FirestoreService.manager.getPartnersUserData(partnerEmailAddress: partnerEmailAddress) { (result) in
            switch result {
            case .success(let users):
                print(users[0])
                
                let partner = users[0]
                let coupleID = Auth.auth().currentUser!.uid + partner.uid
                
                self.updatePartnerUsernameAndCoupleID(partnerUserName: partner.userName, coupleID: coupleID)
                self.updatePartnersField(partnerUID: partner.uid, coupleID: coupleID)
                FirestoreService.manager.removeInvitesFromUser(userEmail: partnerEmailAddress) {[weak self] (result) in
                    self?.handleRemoveInvitesFromUser(result: result)
                }

            case .failure(let error):
                print("unable to get partner user data \(error)")
            }
        }
    }
    
    private func removeInvite(invite: Invites) {
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

extension InvitesPendingVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let returnedView = UIView(frame: CGRect(x: 0, y: 0, width: 200, height: 20))
        returnedView.backgroundColor = .clear
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: 200, height: 20))
        label.text = "Invites Pending"
        label.textColor = #colorLiteral(red: 0.9164920449, green: 0.7743749022, blue: 0.9852260947, alpha: 1)
        returnedView.addSubview(label)
        return returnedView
       
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
                
                if inviteList.count == 0 {
                    self.invitesPendingView.invitesPendingTableView.isHidden = true
                } else {
                    self.invitesPendingView.invitesPendingTableView.isHidden = false
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
        
        updateInvitationStatus(inviteID: invite.id)
        updatePartnerEmailField(partnerEmail: invite.from)
        getPartnerUserData(partnerEmailAddress: invite.from)
        FirestoreService.manager.removeInvitesFromUser(userEmail: currentUserEmail) { [weak self] (result) in
            self?.handleRemoveInvitesFromUser(result: result)
        }
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


