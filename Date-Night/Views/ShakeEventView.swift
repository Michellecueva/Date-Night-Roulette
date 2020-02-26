

import UIKit

class ShakeEventView: UIView {
    
    
   // var shakeIndex = ShakeGestureVC()
    
    
    var demoData = DummyData()
    var infoTopConstraint = NSLayoutConstraint()
    var infoLeadConstraint = NSLayoutConstraint()
        
        lazy var shakeImage: UIImageView = {
           let image = UIImageView()
            image.image = UIImage(named: demoData.eventObj[0].image)
            return image
        }()
        
        lazy var shakeInfoEye: UIButton = {
            let button = UIButton()
            button.setImage(UIImage(systemName: "eye"), for: .normal)
            button.isUserInteractionEnabled = true
            button.addTarget(self, action: #selector(animateShowInfo), for: .touchUpInside)
            return button
        }()
        
        lazy var shakeInfoDetailTextView: UITextView = {
            let textview = UITextView()
            textview.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
            textview.alpha = 0.0
            textview.layer.shadowColor = .init(srgbRed: 0.5, green: 0.5, blue: 0.5, alpha: 0.9)
            textview.adjustsFontForContentSizeCategory = true
            textview.font = UIFont(name: "Arial", size: 30)
//            textview.isUserInteractionEnabled = false
            textview.textColor = .clear
            textview.text = " "
            textview.text = demoData.eventObj[0].longDesc
            return textview
        }()
           
        override init(frame: CGRect) {
            super.init(frame: frame)
            self.backgroundColor = .red
            setSubviews()
            setConstraints()
            
            infoLeadConstraint.constant = self.frame.width - 10
            infoTopConstraint.constant = self.frame.height - 50
        }
        
        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
        
        private enum State {
            case expanded
            case collapsed
            
            var change: State {
                switch self {
                case .expanded:
                    return .collapsed
                case .collapsed:
                    return .expanded
                }
            }
        }
        
        //Mark: Properties
        
        private var initialFrame: CGRect?
        private var state: State = .expanded
        private var collectionView: UICollectionView?
        private var index: Int?
        
        private func setSubviews() {
            self.addSubview(shakeImage)
            self.addSubview(shakeInfoDetailTextView)
            self.addSubview(shakeInfoEye)
            
        }
    
        @objc func animateShowInfo(_ viewToAnimate:UITextView)  {
            
            UIView.animate(withDuration: 1, delay: 0, usingSpringWithDamping: 0.4, initialSpringVelocity: 0.1, options: .curveEaseInOut, animations: {
                
                switch self.state {
                case .collapsed:
                    self.infoLeadConstraint.constant = 0
                    self.infoTopConstraint.constant = 70
                    self.layoutIfNeeded()
                    self.shakeInfoDetailTextView.textColor = #colorLiteral(red: 0.9164920449, green: 0.7743749022, blue: 0.9852260947, alpha: 1)
                    self.shakeInfoDetailTextView.alpha = 0.7
                    self.shakeInfoDetailTextView.text = self.demoData.eventObj.last?.titleLabel ?? ""
                    self.state = .expanded
                    
                case.expanded:
                    self.infoLeadConstraint.constant = self.frame.width - 0
                    self.infoTopConstraint.constant = self.frame.height - 50
                    self.shakeInfoDetailTextView.text = self.demoData.eventObj.last?.longDesc ?? ""

//                    self.infoLeadConstraint.constant = self.frame.width - 40
//                    self.infoTopConstraint.constant = self.frame.height - 40
                    self.layoutIfNeeded()
                    self.shakeInfoDetailTextView.alpha = 0.7
                    self.shakeInfoDetailTextView.textColor = .clear
                    self.state = .collapsed
                }
            })
        }
        
        private func setConstraints() {
            setShakeImageConstraint()
            setShakeInfoEyeConstraints()
             //setInfoDetailConstraints()
            collapseInfoDetailConstraints()
           
        }
        
        private func setShakeImageConstraint() {
            shakeImage.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                shakeImage.topAnchor.constraint(equalTo: self.topAnchor),
                shakeImage.leadingAnchor.constraint(equalTo: self.leadingAnchor),
                shakeImage.trailingAnchor.constraint(equalTo: self.trailingAnchor),
                shakeImage.bottomAnchor.constraint(equalTo: self.bottomAnchor)
            ])
        }
        
        private func setShakeInfoEyeConstraints() {
            shakeInfoEye.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                shakeInfoEye.bottomAnchor.constraint(equalTo: self.shakeImage.bottomAnchor),
                shakeInfoEye.trailingAnchor.constraint(equalTo: self.shakeImage.trailingAnchor),
                shakeInfoEye.leadingAnchor.constraint(equalTo: self.shakeImage.trailingAnchor, constant: -40),
                shakeInfoEye.topAnchor.constraint(equalTo: self.shakeImage.bottomAnchor, constant: -40),
    //            shakeInfoEye.heightAnchor.constraint(equalToConstant: 50),
    //            shakeInfoEye.widthAnchor.constraint(equalToConstant: 50)
                
            
            ])
        }
        
        private func setInfoDetailConstraints() {
            shakeInfoDetailTextView.translatesAutoresizingMaskIntoConstraints = false
            
            NSLayoutConstraint.activate([
                shakeInfoDetailTextView.topAnchor.constraint(equalTo: self.shakeImage.topAnchor, constant: 70),
                shakeInfoDetailTextView.trailingAnchor.constraint(equalTo: self.shakeImage.trailingAnchor),
                shakeInfoDetailTextView.leadingAnchor.constraint(equalTo: self.shakeImage.leadingAnchor),
                shakeInfoDetailTextView.bottomAnchor.constraint(equalTo: self.shakeImage.bottomAnchor)
            ])
        }
        
        
        private func collapseInfoDetailConstraints() {
            shakeInfoDetailTextView.translatesAutoresizingMaskIntoConstraints = false
            infoTopConstraint = shakeInfoDetailTextView.topAnchor.constraint(equalTo: self.shakeImage.topAnchor, constant: -50)
            infoLeadConstraint = shakeInfoDetailTextView.leadingAnchor.constraint(equalTo: self.shakeImage.leadingAnchor, constant: 0)
            
//            infoTopConstraint = shakeInfoDetailTextView.topAnchor.constraint(equalTo: self.shakeImage.topAnchor, constant: frame.height - 70)
//            infoLeadConstraint = shakeInfoDetailTextView.leadingAnchor.constraint(equalTo: self.shakeImage.leadingAnchor, constant: 0)

            NSLayoutConstraint.activate([
                shakeInfoDetailTextView.bottomAnchor.constraint(equalTo: self.shakeImage.bottomAnchor),
                shakeInfoDetailTextView.trailingAnchor.constraint(equalTo: self.shakeImage.trailingAnchor),
                shakeInfoDetailTextView.heightAnchor.constraint(equalToConstant: 70),
    //            shakeInfoDetailTextView.leadingAnchor.constraint(equalTo: self.shakeImage.leadingAnchor, constant: contentView.frame.width - 40),
    //            shakeInfoDetailTextView.topAnchor.constraint(equalTo: self.shakeImage.topAnchor, constant: contentView.frame.height - 40),
                infoTopConstraint,
                infoLeadConstraint
            ])
            
        }
        
        
    }

