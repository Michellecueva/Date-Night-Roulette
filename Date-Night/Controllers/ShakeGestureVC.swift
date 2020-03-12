
import UIKit
import FirebaseFirestore
import FirebaseAuth


//shake gesture only works on first responder
class ShakeGestureVC: UIViewController {
    
    var eventIndexCount = 0
    
    var eventTitle: String!
    
    var pageControl:UIPageControl = UIPageControl(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
    
    var shakeView = ShakeGestureView()
    var fbEvents:[FBEvents] = [] {
        didSet {
            guard fbEvents.count != 0 else {
                navigationController?.popViewController(animated: true)
                return
            }
            setUpView()
            print(fbEvents.count)
            
        }
    }
    
    var eventsLiked = [String]() {
        didSet {
            UserDefaultsWrapper.standard.store(eventsLikedArr: eventsLiked)
        }
    }
    
    var currentUser:AppUser? {
      didSet {
        addListenerOnPartner()
      }
    }
    
    var partnersEventsLiked = [String]()
    
    private var partnerListener: ListenerRegistration?
    
    private let db = Firestore.firestore()
    
    private var collectionReference:CollectionReference {
        return db.collection("users")
    }
    
    deinit {
        partnerListener?.remove()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(shakeView)
        view.backgroundColor = .black
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.makeNavBarTranslucent()
        configurePageControl()
        addObjcFunctionsToViewButtons()
        getAppUser()
        getPriorEventsLiked()
    }
    
    override func viewDidAppear(_ animated:Bool) {
        super.viewDidAppear(animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }
    
    private func addObjcFunctionsToViewButtons() {
        shakeView.confirmButton.addTarget(self, action: #selector(likedButtonPressed), for: .touchUpInside)
    }
    
    func shakeTheEvent() {
        
        setUpView()
        shakeView.layoutIfNeeded()
        fbEvents.popLast()
        pageControl.currentPage = pageControl.currentPage + 1
        print("shake event func called")
        shakeView.confirmButton.isEnabled = true
    }
    
    private func configurePageControl() {
        self.pageControl.numberOfPages = fbEvents.count
        self.pageControl.currentPage = 0
        self.pageControl.tintColor = #colorLiteral(red: 0.9164920449, green: 0.7743749022, blue: 0.9852260947, alpha: 1)
        self.pageControl.pageIndicatorTintColor = UIColor.white
        self.pageControl.currentPageIndicatorTintColor = #colorLiteral(red: 0.9767183661, green: 0.2991916835, blue: 1, alpha: 1)
        pageControl.isUserInteractionEnabled = false
        pageControl.translatesAutoresizingMaskIntoConstraints = false
        
        navigationItem.titleView = pageControl
        pageControl.transform = CGAffineTransform(scaleX: 1.5, y: 1.5)
        
    }
    
//       private func createImageViews(imageURLS:[String]) {
//           // var arrayOfImageViews:[UIImageView] = []
//            var distanceFromCenter:CGFloat = 0
//            imageURLS.forEach({
//    //           UIImageView(imageURL: $0, containerView: view, distanceFromCenter: distanceFromCenter)
//                print($0)
//                SwipeImageView(angle: 10).setUp(imageURL: $0, containerView: view, distanceFromCenter: distanceFromCenter, panGesture: UIPanGestureRecognizer(target: self, action: #selector(panGesture(sender:))))
//
//
//                distanceFromCenter -= 15
//
//
//            })
//
//
//        }
    private func createImageViews(image:UIImage) {
            
        SwipeImageView(angle: 0).setUp(imageURL: nil, uiImage: image, containerView: view, distanceFromCenter: 0, panGesture:UIPanGestureRecognizer(target: self, action: #selector(panGesture(sender:))) )
            
        
             }
                 
           
         
        
        
        
        @objc private func panGesture(sender:UIPanGestureRecognizer) {
              
              let card = sender.view
              
            let imageView = card as! SwipeImageView
            print(card?.superview)
             let containerView = card!.superview
            
              let pointer = sender.translation(in: containerView)
              
            card?.center = CGPoint(x: view.center.x + pointer.x, y: (containerView?.center.y)! + pointer.y)

              
            let xFromCenter = (card?.center.x)! - (containerView?.center.x)!
            let rotation = (xFromCenter / ((containerView?.frame.width)! / 2)) * 0.61
              // for full rotation make sure rotation value is over 1 (divide xFromCenter seperately)
            let twentyFivePercentAwayFromCenter = (containerView?.center.x)!  * 0.25
              
            let twentyFivePercentAwayFromCenterToTheLeft = (containerView?.center.x)! * -0.25
              
              let scaler = min(abs(80/xFromCenter), 1)
             
            if card?.center.y != containerView?.center.y  {
                card?.center.y = (containerView?.center.y)!
                  }
              print(scaler)
              card?.transform = CGAffineTransform(rotationAngle: rotation).scaledBy(x: scaler, y: scaler)
        
              if xFromCenter > 0 {
                imageView.thumbDirection = .up
                imageView.thumbSymbol.tintColor = .green
              } else {
                imageView.thumbDirection = .down
                   imageView.thumbSymbol.tintColor = .red
              }
               imageView.thumbSymbol.alpha = abs(xFromCenter / view.center.x)
             
              if sender.state == .ended {
                  print(xFromCenter)
                  
                  if xFromCenter > 0 && xFromCenter < twentyFivePercentAwayFromCenter {
                              
                                UIView.animate(withDuration: 0.2) {

                                            card?.center = self.view.center
                                    imageView.thumbSymbol.alpha = 0
                                  
                                  card?.transform = .identity

                                       }
                                return
                  } else if xFromCenter < 0 && xFromCenter > twentyFivePercentAwayFromCenterToTheLeft {
                      
                      UIView.animate(withDuration: 0.2) {

                                                              card?.center = self.view.center
                        imageView.thumbSymbol.alpha = 0
                          card?.transform = .identity

                                                         }
                                     return
                  } else if xFromCenter >= twentyFivePercentAwayFromCenter {
                      UIView.animate(withDuration: 0.8) {
                          card?.center = CGPoint(x: self.view.frame.maxX + (self.view.frame.width * 0.5), y: (card?.center.y)! + ((card?.center.y)! / 2))
                        imageView.thumbSymbol.alpha = 0
                        imageView.alpha = 0
                        imageView.removeFromSuperview()

                      }
                          return
                  } else if xFromCenter <= twentyFivePercentAwayFromCenterToTheLeft
                          {
                      UIView.animate(withDuration:0.8) {
                          card?.center = CGPoint(x: self.view.frame.minX - (self.view.frame.width * 0.5), y: (card?.center.y)! + ((card?.center.y)! / 2) )
                        imageView.alpha = 0
                        imageView.thumbSymbol.alpha = 0
                        imageView.removeFromSuperview()

                      }
                      return
                  }

             
              }
              
              
              }
          
        
    
    @objc private func likedButtonPressed() {
        guard let eventID = fbEvents.last?.eventID else {return}
        
        eventsLiked.append(eventID)
        updateEventsLikedOnFirebase(eventsLiked: eventsLiked)
        
        guard let lastEventLiked = eventsLiked.last else {return}
        if partnersEventsLiked.contains(lastEventLiked) {
            guard let coupleID = currentUser?.coupleID else {
                       print("no user found")
                       return
                   }
            let matchedEvent = MatchedEvent(coupleID: coupleID, title: eventTitle, eventID: eventID)
            createMatchedEvent(matchedEvent: matchedEvent)
            
            matchAlert(title: "It's a Match!", message: "You've Matched Events With Your Partner")
            clearEventsLikedArr()
            
        }else {
            shakeTheEvent()
        }
    }
    
    
    private func getPriorEventsLiked() {
        if let eventsArr = UserDefaultsWrapper.standard.getEventsLiked() {
            guard eventsArr.count > 0 else {return}
        }
        
        //maybe pull events from firebase instead
        
    }
    
    private func getAppUser() {
        guard let user = Auth.auth().currentUser else {return}
        FirestoreService.manager.getUser(userID: user.uid) { (result) in
            switch result {
            case .success(let appUser):
                self.currentUser = appUser
                print("****** this is the partner email\(appUser.partnerEmail)")
            case .failure(let error):
                print("unable to get appUser in gesture VC \(error)")
            }
        }
    }
    
    private func updateEventsLikedOnFirebase(eventsLiked: [String]) {
        FirestoreService.manager.updateEventsLiked(eventsLiked: eventsLiked) { (result) in
            switch result {
            case .success(()):
                print("Updated Events Liked")
            case .failure(let error):
                print("Did not update events liked \(error)")
            }
        }
    }
    
    private func createMatchedEvent(matchedEvent: MatchedEvent) {
        FirestoreService.manager.createMatchedEvent(matchedEvent: matchedEvent) { (result) in
            switch result {
            case .success(()):
                print("able to save matched event")
            case .failure(let error):
                print("not able to save matched event \(error)")
            }
        }
    }
    
    private func matchAlert(title:String,message:String) {
        //move to extension
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let confirmMatch = UIAlertAction(title: "Confirm", style: .default) { (response) in
            self.navigationController?.pushViewController(RootViewController(), animated: true)
        }
        let deny = UIAlertAction(title: "Deny", style: .destructive)
        
        alertController.addAction(confirmMatch)
        alertController.addAction(deny)
        present(alertController,animated: true)
    }
    
    private func clearEventsLikedArr() {
        eventsLiked = []
        updateEventsLikedOnFirebase(eventsLiked: eventsLiked)
    }
    
    
    private func addListenerOnPartner() {
        
        guard let currentUser = currentUser else {return}
        
        partnerListener = collectionReference.whereField("email", isEqualTo: currentUser.partnerEmail!)
            .addSnapshotListener({ (snapshot, error) in
                
                if let error = error {
                    print(error.localizedDescription)
                }
                guard let usersFromOnline = snapshot?.documents else {
                    print("no invites available")
                    return
                }
                let userList = usersFromOnline.compactMap { (snapshot) -> AppUser? in
                    let userID = snapshot.documentID
                    let data = snapshot.data()
                    return AppUser(from: data, id: userID)
                }
                
                print("*******listener on PartnerUser \(userList[0].eventsLiked)")
                
                self.partnersEventsLiked = userList[0].eventsLiked
                
            })
    }
    
    private func setUpView() {
        
        guard let lastEvent = self.fbEvents.last else {return}
        eventTitle = lastEvent.title
        if let image = lastEvent.imageURL {
            
            //remember to stop user interaction until image finishes loading
            ImageHelper.shared.getImage(urlStr: image) { [weak self](result) in
                DispatchQueue.main.async {
                    
                    
                    switch result {
                    case .failure(let error):
                        print(error)
                        self?.shakeView.shakeEventView.setUpImage(from:lastEvent , image: UIImage(systemName: "photo")!)
                    case .success(let image):
                        
                        self?.shakeView.shakeEventView.setUpImage(from: lastEvent, image: image)
                    //     self?.createImageViews(image: image)
                    }
                }
            }
        } else {
            self.shakeView.shakeEventView.setUpImage(from:lastEvent , image: UIImage(systemName: "photo")!)
        }
    }
    
    
    override func becomeFirstResponder() -> Bool {
        return true
    }
    
    override func motionBegan(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
        shakeTheEvent()
        print("Shake has happened")
    }
    
    override func motionEnded(_ motion: UIEvent.EventSubtype, with event: UIEvent?){
        if motion == .motionShake
        {
            print("Shake Gesture Detected")
            //show some alert here
        }
    }
}
