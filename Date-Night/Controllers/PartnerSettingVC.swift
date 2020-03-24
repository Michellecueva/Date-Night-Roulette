import UIKit
import FirebaseAuth
import FirebaseFirestore

class PartnerSettingVC: UIViewController {
    
    var matchedEvents: [MatchedEvent] = [] {
        didSet{
            createSnapshot(from: matchedEvents)
        }
    }
    
    var partnerView = PartnerSettingView()
    
    private var isListenerEnabled:Bool = false
    
    var profilePartnerUser:AppUser? {
          didSet {
              print("partner profile VC received partner")
            //possibly change to layout subviews
           
              partnerView.partnerNameLabel.text = "Partner: \(profilePartnerUser?.userName ?? "")"
                setUpProfilePortrait()
            
            guard isListenerEnabled == true else {
                addMatchedEventListener()
                isListenerEnabled = true
                return
            }
            
          }
      }
    
    private var dataSource: UITableViewDiffableDataSource<Section, MatchedEvent>!
    
    
    private let db = Firestore.firestore()
    
    private var matchedEventListener: ListenerRegistration?
    
    private var collectionReference:CollectionReference {
           return db.collection("MatchedEvents")
    }
    
 
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        view.addSubview(partnerView)
        configureDataSource()
        //addObjcFunctionToRemovePartnerButton()
        self.partnerView.historyTable.delegate = self
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        partnerView.portraitPic.layer.cornerRadius = partnerView.portraitPic.bounds.size.width / 2
    }
    

    private func configureDataSource(){
        dataSource = UITableViewDiffableDataSource<Section, MatchedEvent>(tableView: partnerView.historyTable, cellProvider: { (tableView, indexPath, MatchedEvents) -> UITableViewCell? in
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
        
        guard let partner = profilePartnerUser else {return}
        
        matchedEventListener = collectionReference.whereField(
               "coupleID",
               isEqualTo: partner.coupleID!
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
                    self.partnerView.historyTable.isHidden = true
                    self.partnerView.noEventsLabel.isHidden = false
                   } else {
                        self.partnerView.historyTable.isHidden = false
                        self.partnerView.noEventsLabel.isHidden = true
                   }
                    print("inviteList: \(eventList)")
                    self.matchedEvents = eventList
                
                   
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
                         self?.partnerView.portraitPic.image = image
                     }
                 }
             }
         }
    
    private func getMatchedEvents(coupleID: String) {
        FirestoreService.manager.getMatchedHistory(coupleID: coupleID) { (result) in
            switch result {
            case .success(let matchedEventsOnline):
                self.matchedEvents = matchedEventsOnline
            case .failure(let error):
                print("unable to get matched Events \(error)")
            }
        }
    }
    
//     private func addObjcFunctionToRemovePartnerButton() {
//            partnerView.removePartnerButton.addTarget(self, action: #selector(removePartner), for: .touchUpInside)
//        }
//
     /*   @objc private func removePartner() {
        // determine when we want to remove the invites sent from a a user
            
            
            
            FirestoreService.manager.deleteMatchedEvents(coupleID: profilePartnerUser?.coupleID) { [weak self](result) in
                self?.handlePartnerRemoval(result: result)
            }
            
          
            FirestoreService.manager.removePartnerReferencesInUserCollection(uid: Auth.auth().currentUser?.uid, partnerUID: profilePartnerUser?.uid) { [weak self](result) in
                self?.handlePartnerRemoval(result: result)
            }
    }
    
    private func handlePartnerRemoval(result:Result<(),AppError>) {
        switch result {
        case .failure(let error):
            print(error)
        case .success():
            print("successfully removed partner reference")
        }
    }*/
}

extension PartnerSettingVC : UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("***** selecting tableview \(indexPath.row)")
        let matchedVC = MatchedEventVC()
        matchedVC.event = matchedEvents[indexPath.row]
        present(matchedVC, animated: true, completion: nil)
    }
}

