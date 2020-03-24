
import UIKit

class MatchedEventView: UIView {
    
    var imageTopConstraint = NSLayoutConstraint()
    var labelTopConstraint = NSLayoutConstraint()
    
    // private var state: State = .collapsed
    
    lazy var matchLabel: UILabel = {
        let mLabel = UILabel()
        mLabel.textColor = StyleGuide.TitleFontStyle.fontColor
        mLabel.text = "You and your Partner Have Matched!"
        mLabel.numberOfLines = 0
        
        mLabel.textAlignment = .center
        mLabel.adjustsFontForContentSizeCategory = true
        mLabel.font = UIFont(name:StyleGuide.TitleFontStyle.fontName, size:StyleGuide.TitleFontStyle.altFontSize)
        return mLabel
    }()
    
    lazy var matchImage: UIImageView = {
        let mImage = UIImageView()
        mImage.backgroundColor = .clear
        mImage.image = UIImage(systemName: "photo")
        return mImage
    }()
    
    //    lazy var confirmButton: UIButton = {
    //        let button = UIButton()
    //        button.setTitle("Confirm", for: .normal)
    //        button.setTitleColor(StyleGuide.ButtonStyle.fontColor, for: .normal)
    //        button.setTitleColor(StyleGuide.ButtonStyle.disabledColor, for: .disabled)
    //        button.titleLabel?.font = UIFont(name: StyleGuide.ButtonStyle.fontName, size: StyleGuide.ButtonStyle.fontSize)
    //        button.backgroundColor = StyleGuide.ButtonStyle.backgroundColor
    //        button.layer.cornerRadius = StyleGuide.ButtonStyle.cornerRadius
    //        button.layer.borderColor = StyleGuide.ButtonStyle.borderColor
    //        button.layer.borderWidth = StyleGuide.ButtonStyle.borderWidth
    //        button.isEnabled = true
    //        return button
    //    }()
    
    
    lazy var moreInfoButton: UIButton = {
        let infoButton = UIButton()
        infoButton.setTitle("More Info", for: .normal)
        // infoButton.setBackgroundImage(UIImage(systemName: "info.circle"), for: .normal)
        //infoButton.imageView?.image = UIImage(systemName: "info.circle")
        infoButton.tintColor = StyleGuide.AppColors.primaryColor
        infoButton.setTitleColor(StyleGuide.ButtonStyle.fontColor, for: .normal)
        //infoButton.setTitleColor(StyleGuide.ButtonStyle.disabledColor, for: .disabled)
        infoButton.titleLabel?.font = UIFont(name: StyleGuide.ButtonStyle.fontName, size: StyleGuide.ButtonStyle.altFontSize)
        infoButton.backgroundColor = StyleGuide.ButtonStyle.backgroundColor
        infoButton.layer.cornerRadius = StyleGuide.ButtonStyle.cornerRadius
        infoButton.layer.borderColor = StyleGuide.ButtonStyle.borderColor
        infoButton.layer.borderWidth = StyleGuide.ButtonStyle.altBorderWidth
        // infoButton.addTarget(self, action: #selector(animateMatchView), for: .touchUpInside)
        return infoButton
    }()
    
    lazy var directionButton: UIButton = {
        let dirButton = UIButton()
        dirButton.setTitle("Directions", for: .normal)
        //dirButton.setBackgroundImage(UIImage(systemName: "map"), for: .normal)
        //dirButton.imageView?.image = UIImage(systemName: "map")
        dirButton.tintColor = StyleGuide.AppColors.primaryColor
        dirButton.setTitleColor(StyleGuide.ButtonStyle.fontColor, for: .normal)
        dirButton.titleLabel?.font = UIFont(name: StyleGuide.ButtonStyle.fontName, size: StyleGuide.ButtonStyle.altFontSize)
        dirButton.backgroundColor = StyleGuide.ButtonStyle.backgroundColor
        dirButton.layer.cornerRadius = StyleGuide.ButtonStyle.cornerRadius
        dirButton.layer.borderColor = StyleGuide.ButtonStyle.borderColor
        dirButton.layer.borderWidth = StyleGuide.ButtonStyle.altBorderWidth
        return dirButton
    }()
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(frame: CGRect) {
        super.init(frame: UIScreen.main.bounds)
        addMatchSubviews()
        setMatchConstraints()
    }

    private func addMatchSubviews() {
        self.addSubview(matchLabel)
        self.addSubview(matchImage)
        //self.addSubview(confirmButton)
        self.addSubview(moreInfoButton)
        self.addSubview(directionButton)
        // self.addSubview(matchInfoDetailTextView)
    }
    
    private func setMatchConstraints() {
        setMatchLabelConstraints()
        setMatchImageConstraints()
        //setConfirmButtonConstraints()
        setInfoButtonConstraints()
        setDirectionButtonConstraints()
    }
    
    private func setMatchLabelConstraints() {
        matchLabel.translatesAutoresizingMaskIntoConstraints = false
        labelTopConstraint = matchLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 150)
        matchLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 40).isActive = true
        matchLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -40).isActive = true
        matchLabel.heightAnchor.constraint(equalToConstant: 90).isActive = true
        NSLayoutConstraint.activate([labelTopConstraint])
    }
    
    private func setMatchImageConstraints() {
        matchImage.translatesAutoresizingMaskIntoConstraints = false
        
        imageTopConstraint = matchImage.topAnchor.constraint(equalTo: self.topAnchor, constant: 250)
        
        matchImage.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        matchImage.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        matchImage.heightAnchor.constraint(equalToConstant: (self.frame.height * 0.46) - 60).isActive = true
        NSLayoutConstraint.activate([imageTopConstraint])
    }
    
    //    private func setConfirmButtonConstraints() {
    //        confirmButton.translatesAutoresizingMaskIntoConstraints = false
    //        NSLayoutConstraint.activate([
    //            confirmButton.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -90),
    //            confirmButton.centerXAnchor.constraint(equalTo: self.centerXAnchor),
    //            confirmButton.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.4),
    //            confirmButton.heightAnchor.constraint(equalToConstant: 30)
    //        ])
    //    }
    
    private func setInfoButtonConstraints() {
        moreInfoButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            moreInfoButton.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -160),
            moreInfoButton.centerXAnchor.constraint(equalTo: self.centerXAnchor, constant: -80),
            moreInfoButton.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.25),
            moreInfoButton.heightAnchor.constraint(equalToConstant: 30)
        ])
    }
    
    private func setDirectionButtonConstraints() {
        directionButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            directionButton.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -160),
            directionButton.centerXAnchor.constraint(equalTo: self.centerXAnchor, constant: 80),
            directionButton.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.25),
            directionButton.heightAnchor.constraint(equalToConstant: 30)
        ])
    }
    
    //    private func setMatchInfoDetailTextViewConstraints() {
    //        matchInfoDetailTextView.translatesAutoresizingMaskIntoConstraints = false
    //        NSLayoutConstraint.activate([
    //            matchInfoDetailTextView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
    //            matchInfoDetailTextView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
    //            matchInfoDetailTextView.widthAnchor.constraint(equalTo: self.widthAnchor),
    //            matchInfoDetailTextView.heightAnchor.constraint(equalTo: self.heightAnchor)
    //        ])
    //    }
    
    
}
