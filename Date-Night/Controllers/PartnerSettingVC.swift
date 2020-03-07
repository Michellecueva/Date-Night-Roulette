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
    
    var profilePartnerUser:AppUser? {
          didSet {
              print("partner profile VC received partner")
            //possibly change to layout subviews
              thePartner.partnerNameLabel.text = "Partner: \(profilePartnerUser?.userName ?? "")"
                setUpProfilePortrait()
          }
      }
    
    private var dataSource: UITableViewDiffableDataSource<Section, MatchedEvent>!
    
    
    private let db = Firestore.firestore()
    
    private var matchedEventListener: ListenerRegistration?
    
    private var collectionReference:CollectionReference {
           return db.collection("MatchedEvents")
    }
    
    var currentUser:AppUser? {
        didSet {
            thePartner.partnerNameLabel.text = "Your partner is \(currentUser?.partnerUserName ?? "")"
            addMatchedEventListener()
            print("currentPartner shown on partner vc")
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        view.addSubview(thePartner)
        configureDataSource()
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
    
    private func addMatchedEventListener() {
        
        guard let currentUser = currentUser else {return}
        
        matchedEventListener = collectionReference.whereField(
               "coupleID",
               isEqualTo: currentUser.coupleID!
            )
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
    
    private func setUpProfilePortrait() {
           guard let partnerPortraitURL = profilePartnerUser?.photoURL else {return}
             ImageHelper.shared.getImage(urlStr: partnerPortraitURL) { [weak self](result) in
                 DispatchQueue.main.async {
                     switch result {
                         
                     case .failure(let error):
                         print(error)
                         
                     case .success(let image):
                         self?.thePartner.portraitPic.image = image
                     }
                 }
             }
         }
}

extension PartnerSettingVC {
    fileprivate enum Section {
        case events
    }
}
