
import UIKit

class InvitesPendingVC: UIViewController {
    
    var invites = [
          Invites(from: "Test", to: "Michelle", invitationStatus: invitationStatus.pending),
          Invites(from: "Test 2", to: "Steven", invitationStatus: invitationStatus.pending),
          Invites(from: "Test 3", to: "Person", invitationStatus:invitationStatus.pending)
      ]
    
    let invitesPendingView = InvitesPendingView()
    
    private var dataSource: UITableViewDiffableDataSource<Section, Invites>!

    override func viewDidLoad() {
        super.viewDidLoad()
        print(FirebaseAuthService.manager.currentUser?.email)
        view.addSubview(invitesPendingView)
        configureDataSource()
        createSnapshot(from: invites)
    }
    
    private func configureDataSource() {
        dataSource = UITableViewDiffableDataSource<Section, Invites>(tableView: invitesPendingView.invitesPendingTableView, cellProvider: { (tableView, indexPath, Invite) -> UITableViewCell? in
            let cell = tableView.dequeueReusableCell(withIdentifier: "invitesCell", for: indexPath)
            cell.textLabel?.text = Invite.to
            cell.textLabel?.textColor = #colorLiteral(red: 0.5568627715, green: 0.3529411852, blue: 0.9686274529, alpha: 1)
            cell.backgroundColor = .clear
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
    fileprivate enum Section {
        case main
    }
}
