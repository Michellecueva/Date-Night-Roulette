
import UIKit

class InvitesPendingView: UIView {
    
    lazy var invitesPendingTableView: UITableView = {
        let tableview = UITableView()
        tableview.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        tableview.separatorColor = #colorLiteral(red: 0.9164920449, green: 0.7743749022, blue: 0.9852260947, alpha: 1)
        tableview.register(InvitesCell.self, forCellReuseIdentifier: InvitesCell.identifier)
        tableview.tableFooterView = UIView(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
        return tableview
       }()
    
//    lazy var InvitesPendingLabel: UILabel = {
//        let label = UILabel()
//        label.text = "Invites Pending"
//        label.textColor = #colorLiteral(red: 0.5568627715, green: 0.3529411852, blue: 0.9686274529, alpha: 1)
//        label.textAlignment = .center
//        return label
//    }()
    
    override init(frame: CGRect) {
        super.init(frame: UIScreen.main.bounds)
        addSubview()
        addContraints()
        self.backgroundColor = .black
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    private func addSubview() {
        addSubview(invitesPendingTableView)
//        addSubview(InvitesPendingLabel)
    }
    
    private func addContraints() {
     //    addLabelContraints()
        addTableViewContraints()
    }
    
//    private func addLabelContraints() {
//        InvitesPendingLabel.translatesAutoresizingMaskIntoConstraints = false
//        NSLayoutConstraint.activate([
//            InvitesPendingLabel.bottomAnchor.constraint(equalTo: self.invitesPendingTableView.topAnchor),
//            InvitesPendingLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor),
//            InvitesPendingLabel.heightAnchor.constraint(equalToConstant: 50),
//            InvitesPendingLabel.widthAnchor.constraint(equalToConstant: 200)
//        ])
//    }
    
    private func addTableViewContraints() {
           invitesPendingTableView.translatesAutoresizingMaskIntoConstraints = false
           NSLayoutConstraint.activate([
            invitesPendingTableView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
                invitesPendingTableView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
                invitesPendingTableView.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.7),
                invitesPendingTableView.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.9)
          ])
       }
}
