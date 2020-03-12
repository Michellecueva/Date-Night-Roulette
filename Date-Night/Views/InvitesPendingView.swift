
import UIKit

class InvitesPendingView: UIView {
    
    lazy var invitesPendingTableView: UITableView = {
        let tableview = UITableView()
        tableview.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        tableview.separatorColor = StyleGuide.AppColors.primaryColor
        tableview.register(InvitesCell.self, forCellReuseIdentifier: InvitesCell.identifier)
        tableview.tableFooterView = UIView(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
        return tableview
       }()
    

    lazy var noInvitesLabel: UILabel = {
        let label = UILabel()
        label.text = "No Pending Invites"
        label.textColor = StyleGuide.FontStyle.fontColor
        label.textAlignment = .center
        return label
    }()
    
    lazy var dateNightLogo:UIImageView = {
        let dnl = UIImageView()
        dnl.contentMode = .scaleAspectFit
        dnl.image = UIImage(named:"splashLogo")
        return dnl
    }()

    
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
        self.addSubview(invitesPendingTableView)
        self.addSubview(dateNightLogo)

    }
    
    private func addContraints() {
        addTableViewContraints()
        logoConstraints()
    }
    
    private func addTableViewContraints() {
           invitesPendingTableView.translatesAutoresizingMaskIntoConstraints = false
           NSLayoutConstraint.activate([
            invitesPendingTableView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
                invitesPendingTableView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
                invitesPendingTableView.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.7),
                invitesPendingTableView.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.9)
          ])
       }
    
    private func logoConstraints() {
        dateNightLogo.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            dateNightLogo.topAnchor.constraint(equalTo: self.topAnchor),
            dateNightLogo.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            dateNightLogo.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            dateNightLogo.leadingAnchor.constraint(equalTo: self.leadingAnchor),

        ])
    }
}
