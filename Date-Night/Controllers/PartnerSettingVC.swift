import UIKit

class PartnerSettingVC: UIViewController {

    var thePartner = PartnerSettingView()
    var dummyArray = ["Bear Mountain Hiking", "Fall Out Boy Concert", "Kings Comedy Club", "Biking on the Promenade", "Taco Tuesdays @ San Loco", "1OAK", "Paint & Sip", "Pottery Making Class"]
    
    var currentUser:AppUser? {
        didSet {
            thePartner.partnerNameLabel.text = "Your partner is \(currentUser?.partnerUserName ?? "")"
            
               }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        view.addSubview(thePartner)
        thePartner.historyTable.delegate = self
        thePartner.historyTable.dataSource = self
    }
    
}

extension PartnerSettingVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dummyArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = thePartner.historyTable.dequeueReusableCell(withIdentifier: "historyCell", for: indexPath)
        cell.backgroundColor = #colorLiteral(red: 0.9092509151, green: 0.7310814261, blue: 1, alpha: 1)
        cell.textLabel?.text = dummyArray[indexPath.row]
        return cell
    }
    
    
}
