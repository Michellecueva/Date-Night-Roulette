import UIKit

class PartnerSettingView: UIView {

   lazy var portraitPic: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(systemName: "person.crop.circle.badge.plus")
        return image
    }()
    
    lazy var historyTable: UITableView = {
        let table = UITableView()
        table.register(UITableViewCell.self, forCellReuseIdentifier: "historyCell")
        table.backgroundColor = #colorLiteral(red: 0.9092509151, green: 0.7310814261, blue: 1, alpha: 1)
        return table
    }()
    
    lazy var removePartnerButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Remove Partner", for: .normal)
        button.setTitleColor(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 1), for: .normal)
        button.backgroundColor = #colorLiteral(red: 0.9092509151, green: 0.7310814261, blue: 1, alpha: 1)
        button.titleLabel?.font = UIFont(name: "Arial", size: 20)
        button.layer.cornerRadius = 5
        button.isEnabled = true
        return button
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: UIScreen.main.bounds)
        self.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        setSubviews()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func setSubviews() {
        self.addSubview(portraitPic)
        self.addSubview(historyTable)
        self.addSubview(removePartnerButton)
    }
    
    
    
    private func setConstraints() {
        setPortraitConstraints()
        setTableConstraints()
        setRemoveButtonConstraints()
    }
    
    private func setPortraitConstraints() {
        portraitPic.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            portraitPic.topAnchor.constraint(equalTo: self.topAnchor, constant: self.frame.height * 0.1),
            portraitPic.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            portraitPic.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.5),
            portraitPic.heightAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.4)
        ])
    }
    
    private func setTableConstraints() {
        historyTable.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            historyTable.topAnchor.constraint(equalTo: portraitPic.bottomAnchor, constant: 30),
            historyTable.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 70),
            historyTable.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -70),
            historyTable.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.4)
        ])
    }
    
    private func setRemoveButtonConstraints() {
        removePartnerButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            removePartnerButton.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -50),
            removePartnerButton.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            removePartnerButton.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.4),
            removePartnerButton.heightAnchor.constraint(equalToConstant: 30)
        ])
    }
    
    
}
