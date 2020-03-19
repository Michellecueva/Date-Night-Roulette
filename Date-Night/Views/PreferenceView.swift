
import UIKit

private let cellIdentifier = "PreferenceCell"

class PreferenceView: UIView {
    
    lazy var preferenceCollectionView: UICollectionView = {
        var layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout.init()
        let cv = UICollectionView(frame: UIScreen.main.bounds, collectionViewLayout: layout)
        layout.scrollDirection = .vertical
        cv.backgroundColor = .clear
        layout.sectionInset = UIEdgeInsets(top: 30, left: 3, bottom: 0, right: 3)
        cv.register(PreferenceCell.self, forCellWithReuseIdentifier: cellIdentifier)
        cv.layer.borderColor = UIColor.black.cgColor
        cv.layer.borderWidth = 2
        return cv
    }()
    
    
    lazy var saveButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Save!", for: .normal)
        button.setTitleColor(StyleGuide.ButtonStyle.fontColor, for: .normal)
        button.setTitleColor(.systemGray, for: .disabled)
        button.titleLabel?.font = UIFont(name: StyleGuide.ButtonStyle.fontName, size: StyleGuide.ButtonStyle.fontSize)
        button.backgroundColor = StyleGuide.ButtonStyle.backgroundColor
        button.layer.cornerRadius = StyleGuide.ButtonStyle.cornerRadius
        button.layer.borderColor = StyleGuide.ButtonStyle.borderColor
        button.layer.borderWidth = StyleGuide.ButtonStyle.borderWidth
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: UIScreen.main.bounds)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func addSubviews() {
        self.addSubview(preferenceCollectionView)
        self.addSubview(saveButton)
    }
    
    private func commonInit(){
        addSubviews()
        cvConstraints()
        buttonConstraints()
        self.backgroundColor = .black
        //self.layer.borderColor = UIColor.gray.cgColor
        self.layer.borderWidth = 3
    }
    //MARK:- Constraints
    
    private func cvConstraints() {
        preferenceCollectionView.translatesAutoresizingMaskIntoConstraints = false
        preferenceCollectionView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: self.frame.height * 0.05).isActive = true
        preferenceCollectionView.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor).isActive = true
        preferenceCollectionView.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor).isActive = true
       preferenceCollectionView.bottomAnchor.constraint(equalTo: saveButton.topAnchor, constant: -0.05 * self.frame.height).isActive = true
    }
    
    private func buttonConstraints(){
        saveButton.translatesAutoresizingMaskIntoConstraints = false
        saveButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        saveButton.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 90).isActive = true
        saveButton.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -90).isActive = true
        saveButton.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor, constant: -50).isActive = true
    }
    
    
}
