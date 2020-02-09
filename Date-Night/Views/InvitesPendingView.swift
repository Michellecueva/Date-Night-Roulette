
import UIKit

class InvitesPendingView: UIView {
    
    lazy var invitesPendingTableView: UITableView = {
        let tableview = UITableView()
        tableview.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        tableview.separatorColor = #colorLiteral(red: 0.5568627715, green: 0.3529411852, blue: 0.9686274529, alpha: 1)
        tableview.register(InvitesPendingCell.self, forCellReuseIdentifier: "invitesCell")
        tableview.tableFooterView = UIView(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
        return tableview
       }()
    
    override init(frame: CGRect) {
        super.init(frame: UIScreen.main.bounds)
        addSubview()
        addContraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    private func addSubview() {
        addSubview(invitesPendingTableView)
    }
    
    private func addContraints() {
        invitesPendingTableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            invitesPendingTableView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            invitesPendingTableView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            invitesPendingTableView.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.8),
            invitesPendingTableView.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.9)
        ])
    }
}
