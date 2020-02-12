
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
        //change invitationStatus property from pending to accepted
        //update user's partner in firebase
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
