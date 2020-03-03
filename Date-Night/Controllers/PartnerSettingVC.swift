import UIKit
import FirebaseAuth
import FirebaseFirestore

class PartnerSettingVC: UIViewController {
    
    var matchedEvents: [MatchedEvent] = [] {
        didSet{
            createSnapshot(from: matchedEvents)
        }
    }
    
    var thePartner = PartnerSettingView()
    
    private var dataSource: UITableViewDiffableDataSource<Section, MatchedEvent>!
    
    
    private let db = Firestore.firestore()
    
    private var matchedEventListener: ListenerRegistration?
    
    private var collectionReference:CollectionReference {
           return db.collection("MatchedEvents")
    }
    
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
        addMatchedEventListener()
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
    
    private func addMatchedEventListener() {
        
        guard let userID = Auth.auth().currentUser?.uid else {
                   print("no current user")
                   return
                   
               }
        guard let partnerID = UserDefaultsWrapper.standard.getPartnerUID() else {return}
        
        matchedEventListener = collectionReference.whereField(
               "userOne",
               isEqualTo: userID
            )
            .whereField("userTwo", isEqualTo: partnerID)
               .addSnapshotListener({ (snapshot, error) in
                   
                   if let error = error {
                       print(error.localizedDescription)
                   }
                   guard let eventsFromOnline = snapshot?.documents else {
                       print("no events available")
                       return
                   }
                   let eventList = eventsFromOnline.compactMap { (snapshot) -> MatchedEvent? in
                       let eventID = snapshot.documentID
                       let data = snapshot.data()
                       return MatchedEvent(from: data, id: eventID)
                   }
                   
                   if eventList.count == 0 {
                    self.thePartner.historyTable.isHidden = true
                    self.thePartner.noEventsLabel.isHidden = false
                   } else {
                        self.thePartner.historyTable.isHidden = false
                        self.thePartner.noEventsLabel.isHidden = true
                   }
                    self.matchedEvents = eventList
                
                   print("inviteList: \(eventList)")
               })
       }
}

extension PartnerSettingVC {
    fileprivate enum Section {
        case events
    }
}
