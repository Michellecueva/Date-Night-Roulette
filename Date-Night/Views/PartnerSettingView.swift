import UIKit

class PartnerSettingView: UIView {

 lazy var portraitPic: UIImageView = {
       let image = UIImageView(frame: UIScreen.main.bounds)
       image.tintColor = #colorLiteral(red: 0.9092509151, green: 0.7310814261, blue: 1, alpha: 1)
       image.backgroundColor = #colorLiteral(red: 0.9092509151, green: 0.7310814261, blue: 1, alpha: 1)
       image.image = UIImage(named: "PortraitPlaceholder")
       image.layer.borderWidth = 1
      // image.layer.cornerRadius =  84//image.frame.size.height/2
       image.layer.masksToBounds = true
       image.layer.borderColor = UIColor.black.cgColor
      // image.clipsToBounds = true
       image.contentMode = .scaleToFill
       //image.image = UIImage(systemName: "person.crop.circle")
       return image
   }()
    
    lazy var partnerNameLabel: UILabel = {
        let label = UILabel()
        label.text = "Partner Username"
        label.font = UIFont(name: StyleGuide.FontStyle.fontName, size: StyleGuide.FontStyle.altFontSize)
        label.adjustsFontSizeToFitWidth = true
        label.textColor = StyleGuide.FontStyle.fontColor
        return label
    }()
    
    lazy var noEventsLabel: UILabel = {
          let label = UILabel()
          label.text = "No Event History"
          label.font = UIFont(name:StyleGuide.FontStyle.fontName, size: StyleGuide.FontStyle.altFontSize)
          label.adjustsFontSizeToFitWidth = true
          label.textAlignment = .center
          label.textColor = #colorLiteral(red: 0.9164920449, green: 0.7743749022, blue: 0.9852260947, alpha: 1)
          return label
      }()
    
    lazy var historyTable: UITableView = {
         let tableview = UITableView()
         tableview.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
         tableview.separatorColor = #colorLiteral(red: 0.9164920449, green: 0.7743749022, blue: 0.9852260947, alpha: 1)
         tableview.register(MatchedCell.self, forCellReuseIdentifier: MatchedCell.identifier)
         tableview.tableFooterView = UIView(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
         return tableview
        }()
     
    
    lazy var removePartnerButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Remove Partner", for: .normal)
        button.setTitleColor(StyleGuide.ButtonStyle.fontColor, for: .normal)
        button.titleLabel?.font = UIFont(name: StyleGuide.ButtonStyle.fontName, size: StyleGuide.ButtonStyle.fontSize)
       button.backgroundColor = StyleGuide.ButtonStyle.backgroundColor
        button.layer.cornerRadius = StyleGuide.ButtonStyle.cornerRadius
        button.layer.borderColor = StyleGuide.ButtonStyle.borderColor
        button.layer.borderWidth = StyleGuide.ButtonStyle.altBorderWidth
        button.isEnabled = true
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: UIScreen.main.bounds)
        self.backgroundColor = StyleGuide.AppColors.backgroundColor
        setSubviews()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func setSubviews() {
        self.addSubview(portraitPic)
        self.addSubview(partnerNameLabel)
        self.addSubview(noEventsLabel)
        self.addSubview(historyTable)
        self.addSubview(removePartnerButton)
    }
    
    private func setConstraints() {
        setPortraitConstraints()
        setPartnerNameLabelConstraints()
        setNoEventsLabelConstraints()
        setTableConstraints()
        setRemoveButtonConstraints()
    }
    
    private func setPortraitConstraints() {
        portraitPic.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            portraitPic.topAnchor.constraint(equalTo: self.topAnchor, constant: self.frame.height * 0.15),
            portraitPic.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            portraitPic.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.4),
            portraitPic.heightAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.4)
        ])
    }
    
    private func setPartnerNameLabelConstraints() {
        partnerNameLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            partnerNameLabel.topAnchor.constraint(equalTo: portraitPic.bottomAnchor, constant: 10),
            partnerNameLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            partnerNameLabel.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.6),
            partnerNameLabel.heightAnchor.constraint(equalToConstant: 30)
        ])
    }
    
    private func setNoEventsLabelConstraints(){
        noEventsLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
        noEventsLabel.topAnchor.constraint(equalTo: partnerNameLabel.bottomAnchor, constant: 20),
        noEventsLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
        noEventsLabel.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.6),
        noEventsLabel.heightAnchor.constraint(equalToConstant: 30)
        ])
    }
    
//    private func setUserEmailLabelConstraints() {
//        partnerNameLabel.translatesAutoresizingMaskIntoConstraints = false
//        NSLayoutConstraint.activate([
//            partnerNameLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: self.frame.height * 0.45),
//            partnerNameLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor, constant: -50),
//            partnerNameLabel.widthAnchor.constraint(equalToConstant: 200),
//            partnerNameLabel.heightAnchor.constraint(equalToConstant: 50)
//        ])
//    }
    
    private func setTableConstraints() {
        historyTable.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            historyTable.topAnchor.constraint(equalTo: partnerNameLabel.bottomAnchor, constant: 70),
            historyTable.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 40),
            historyTable.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -40),
            historyTable.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.4)
        ])
    }
    
    private func setRemoveButtonConstraints() {
        removePartnerButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            removePartnerButton.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -70),
            removePartnerButton.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            removePartnerButton.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.50),
            removePartnerButton.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
    
}
