import UIKit
import FirebaseAuth
import FirebaseFirestore

class PartnerSettingVC: UIViewController {
    
    var matchedEvents: [MatchedEvent] = [] {
        didSet{
            createSnapshot(from: matchedEvents)
            print("these are the matched events \(matchedEvents)")
        }
    }
    
    var thePartner = PartnerSettingView()
    
    private var dataSource: UITableViewDiffableDataSource<Section, MatchedEvent>!
    
    private var eventsListener:
    ListenerRegistration?
    
    private let db = Firestore.firestore()
    
    //   private var collectionReference:CollectionReference {
    //         return db.collection("invites")
    //     }
    //
    //     deinit {
    //         inviteListener?.remove()
    //     }
    
    
    var currentUser:AppUser? {
        didSet {
            thePartner.partnerNameLabel.text = "Your partner is \(currentUser?.partnerUserName ?? "")"
            
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        view.addSubview(thePartner)
        configureDataSource()
        // addListener()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        guard let userID = Auth.auth().currentUser?.uid else {
            print("no current user")
            return
            
        }
        guard let partnerID = UserDefaultsWrapper.standard.getPartnerUID() else {return}
        
        getMatchedEvents(userID: userID, partnerID: partnerID)
    }
    
    
    private func configureDataSource(){
        dataSource = UITableViewDiffableDataSource<Section, MatchedEvent>(tableView: thePartner.historyTable, cellProvider: { (tableView, indexPath, MatchedEvents) -> UITableViewCell? in
            let cell = tableView.dequeueReusableCell(withIdentifier: MatchedCell.identifier, for: indexPath) as! MatchedCell
            cell.configureCell(with: MatchedEvents, row: indexPath.row)
            return cell
        })
    }
    
    private func createSnapshot(from matchedEvents: [MatchedEvent]){
        var snapshot = NSDiffableDataSourceSnapshot<Section, MatchedEvent>()
        snapshot.appendSections([.events])
        snapshot.appendItems(matchedEvents)
        dataSource.apply(snapshot, animatingDifferences: true)
    }
    
    private func getMatchedEvents(userID: String, partnerID: String) {
        FirestoreService.manager.getMatchedHistory(userID: userID, partnerID: partnerID) { (result) in
            switch result {
            case .success(let matchedEventsOnline):
                self.matchedEvents = matchedEventsOnline
            case .failure(let error):
                print("unable to get matched Events \(error)")
            }
        }
    }
}

extension PartnerSettingVC {
    fileprivate enum Section {
        case events
    }
}
