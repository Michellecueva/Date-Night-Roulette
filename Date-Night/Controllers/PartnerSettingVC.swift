import UIKit
import FirebaseAuth
import FirebaseFirestore

class PartnerSettingVC: UIViewController {
    
    var matchedEvents: [MatchedEventsHistory] = [] {
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
    
    private var dataSource: UITableViewDiffableDataSource<Section, MatchedEventsHistory>!
    
    private var eventsListener:
    ListenerRegistration?
    
    private let db = Firestore.firestore()
        
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        view.addSubview(thePartner)
        configureDataSource()
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
       //
        print("layout up subviews")
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
    
    private func configureDataSource(){
        dataSource = UITableViewDiffableDataSource<Section, MatchedEventsHistory>(tableView: thePartner.historyTable, cellProvider: { (tableView, indexPath, MatchedEventsHistory) -> UITableViewCell? in
            let cell = tableView.dequeueReusableCell(withIdentifier: MatchedCell.identifier, for: indexPath) as! MatchedCell
            cell.configureCell(with: MatchedEventsHistory, row: indexPath.row)
            return cell
        })
    }
    
    private func createSnapshot(from matchedEvents: [MatchedEventsHistory]){
        var snapshot = NSDiffableDataSourceSnapshot<Section, MatchedEventsHistory>()
        snapshot.appendSections([.events])
        snapshot.appendItems(matchedEvents)
        dataSource.apply(snapshot, animatingDifferences: true)
    }
}

extension PartnerSettingVC {
    fileprivate enum Section {
        case events
    }
}
