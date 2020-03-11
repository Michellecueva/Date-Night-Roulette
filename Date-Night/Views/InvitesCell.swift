
import UIKit

class InvitesCell: UITableViewCell {
    
    static let identifier = "invitesCell"
    var delegate: CellDelegate?
    
    var nameLabel: UILabel = {
        let label = UILabel()
        return label
    }()
    
    lazy var acceptButton: UIButton = { [unowned self] in
        let button = UIButton()
        button.setImage(UIImage(systemName: "checkmark.circle"), for: .normal)
        button.addTarget(self, action: #selector(acceptButtonPressed), for: .touchUpInside)
        return button
        }()
    
    lazy var declineButton: UIButton = { [unowned self] in
        let button = UIButton()
        button.setImage(UIImage(systemName: "xmark.circle"), for: .normal)
        button.addTarget(self, action: #selector(declineButtonPressed), for: .touchUpInside)
        return button
        }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addSubviews()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    @objc func acceptButtonPressed(sender: UIButton) {
        delegate?.handleAcceptedInvite(tag: sender.tag)
    }
    
    @objc func declineButtonPressed(sender: UIButton) {
        delegate?.handleDeclinedInvite(tag: sender.tag)
    }
    
    func configureCell(with invite: Invites, row: Int) {
        nameLabel.text = invite.from
        nameLabel.textColor = StyleGuide.FontStyle.fontColor
        backgroundColor = .clear
        acceptButton.tag = row
        declineButton.tag = row
    }
    
    private func addSubviews() {
        self.contentView.addSubview(nameLabel)
        self.contentView.addSubview(acceptButton)
        self.contentView.addSubview(declineButton)
    }
    
    private func setConstraints() {
        setNameLabelConstraints()
        setAcceptButtonConstraints()
        setDeclineButtonConstraints()
    }
    
    private func setNameLabelConstraints() {
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            nameLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            nameLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            nameLabel.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.8),
            nameLabel.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 0.6)
        ])
    }
    
    private func setAcceptButtonConstraints() {
        acceptButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            acceptButton.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            acceptButton.trailingAnchor.constraint(equalTo: declineButton.leadingAnchor, constant: 10),
            acceptButton.heightAnchor.constraint(equalToConstant: 50),
            acceptButton.widthAnchor.constraint(equalToConstant: 50),
        ])
    }
    
    private func setDeclineButtonConstraints() {
        declineButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            declineButton.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            declineButton.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor),
            declineButton.heightAnchor.constraint(equalToConstant: 50),
            declineButton.widthAnchor.constraint(equalToConstant: 50),
        ])
    }
    
}
