
import UIKit
import FirebaseFirestore
import FirebaseAuth


//shake gesture only works on first responder
class ShakeGestureVC: UIViewController {
    
    var eventIndexCount = 0
    
    var eventTitle: String!
    
    
    var shakeView = ShakeGestureView()
    var fbEvents:[FBEvents] = [] {
        didSet {
            guard fbEvents.count != 0 else {
                self.testAlert(controllerTitle: "You've Reached The End of Your Events", controllerMessage: "", actionOneTitle: "Ok", actionTwoTitle: nil, actionOneClosure: { (action) in
                    self.navigationController?.popViewController(animated: true)
                }, controllerStyle: .alert, actionTwoClosure: nil, actionOneStyle: .default, actionTwoStyle: nil)
                return
            }
            setUpView(event: fbEvents.last!)
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
    lazy var panGestureRecognizer:UIPanGestureRecognizer = {
        let pan = UIPanGestureRecognizer()
        
        pan.addTarget(self, action: #selector(panGesture))
       
        return pan
    }()
    
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
        shakeView.eventCard.isUserInteractionEnabled = true
        shakeView.eventCard.addGestureRecognizer(panGestureRecognizer)
        view.backgroundColor = .black
        
    }
    
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.makeNavBarTranslucent()
       
        addObjcFunctionsToViewButtons()
        getAppUser()
        getPriorEventsLiked()
        
    }
    
    override func viewDidAppear(_ animated:Bool) {
        super.viewDidAppear(animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
fbEvents = []
        
    }
    
    private func addObjcFunctionsToViewButtons() {
        shakeView.confirmButton.addTarget(self, action: #selector(likedButtonPressed), for: .touchUpInside)
    }
    
    
   @objc private func panGesture(sender:UIPanGestureRecognizer)
   
       {
                   
                   let card = sender.view
                   
                   let pointer = sender.translation(in: view)
                   
                   card?.center = CGPoint(x: view.center.x + pointer.x, y: view.center.y + pointer.y)

                   
                   let xFromCenter = (card?.center.x)! - view.center.x
        
        
           let rotation = (xFromCenter / (view.frame.width / 2)) * 0.93
                   // for full rotation make sure rotation value is over 1 (divide xFromCenter seperately)
                   let distanceFromCenterToTheRight = view.center.x  * 0.50
                   
                   let distanceFromCenterToTheLeft = view.center.x * -0.50
                   
                   let scaler = min(abs(80/xFromCenter), 1)
                  
       //            if card?.center.y != view.center.y  {
       //                card?.center.y = view.center.y
       //                }
                  
                   card?.transform = CGAffineTransform(rotationAngle: rotation).scaledBy(x: scaler, y: scaler)
             
                   if xFromCenter > 0 {
                       card?.layer.borderWidth = 5
                       card?.layer.borderColor = UIColor.green.withAlphaComponent(abs(xFromCenter / view.center.x)).cgColor
                        
                   } else if xFromCenter < 0 {
                         card?.layer.borderWidth = 5
                       card?.layer.borderColor = UIColor.red.withAlphaComponent(abs(xFromCenter / view.center.x)).cgColor
                   }
                   
                   
                  
                   if sender.state == .ended {
                    
                       if xFromCenter > 0 && xFromCenter < distanceFromCenterToTheRight {
                                   
                                     UIView.animate(withDuration: 0.2) {
                                      
                                                 card?.center = self.view.center
                                       card?.layer.borderWidth = 0
                                       card?.layer.borderColor = .none
                                       
                                       card?.transform = .identity
                                       }
                                     return
                       } else if xFromCenter < 0 && xFromCenter > distanceFromCenterToTheLeft {
                           
                           UIView.animate(withDuration: 0.2) {

                             
                                                                  card?.center = self.view.center
                                                                      card?.layer.borderWidth = 0
                                                                                                card?.layer.borderColor = .none
                               
                               card?.transform = .identity

                                                              }
                                          return
                       } else if xFromCenter >= distanceFromCenterToTheRight {
                       
                                       UIView.animate(withDuration: 0.5, animations: {
  
                                            card?.center = CGPoint(x: self.view.frame.maxX + (self.view.frame.width * 0.5), y: (card?.center.y)!)
                                             //
                                                              
                       
                                       }, completion: { (bool) in
                                           self.likedButtonPressed()
                                           self.returnToCenterFromRight()
                                       })
                                           return
                                   } else if xFromCenter <= distanceFromCenterToTheLeft
                                           {
                                      UIView.animate(withDuration: 0.5, animations: {
                       
                                       
                                       card?.center = CGPoint(x: self.view.frame.maxX - (self.view.frame.width * 1.5), y: ((card?.center.y)!))
                                                
                    
                                                      }, completion: { (bool) in
                                                        self.fbEvents.popLast()
                                                self.returnToCenterLeft()
                                                      })
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
            //in the future prevent liked events from showing up at all
            fbEvents.popLast()
        }
    }
    
    private func returnToCenterFromRight() {
        shakeView.eventCard.center = CGPoint(x: view.frame.minX, y: view.center.y )
        shakeView.eventCard.layer.borderWidth = 0
                   shakeView.eventCard.layer.borderColor = .none
           UIView.animate(withDuration: 0.3) {
            self.shakeView.eventCard.alpha = 1
            self.shakeView.eventCard.transform = .identity
            self.shakeView.eventCard.center = CGPoint(x: self.view.center.x, y: self.view.center.y)
           }
           
       }
       
       private func returnToCenterLeft() {
                   shakeView.eventCard.center = CGPoint(x: view.frame.maxX, y: view.center.y )
                   shakeView.eventCard.layer.borderWidth = 0
                   shakeView.eventCard.layer.borderColor = .none
                  UIView.animate(withDuration: 0.3) {
                    self.shakeView.eventCard.alpha = 1
                    self.shakeView.eventCard.transform = .identity
                    self.shakeView.eventCard.center = CGPoint(x: self.view.center.x, y: self.view.center.y)
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

                  let matched = MatchedEventVC()
            matched.newImage = self.shakeView.eventCard.imageView.image
            self.navigationController?.pushViewController(MatchedEventVC(), animated: true)
            
            
                
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
    private func setUpView(event:FBEvents) {
     
          //eventCard.setNeedsDisplay()
        
        shakeView.eventCard.layoutTitleLabel(event: event)
        shakeView.eventCard.layoutDetailView(from:event)
        if let image = event.imageURL {
            
            //remember to stop user interaction until image finishes loading
            ImageHelper.shared.getImage(urlStr: image) { [weak self](result) in
                DispatchQueue.main.async {
                    
                    
                    switch result {
                    case .failure(let error):
                        print(error)
                        self?.shakeView.eventCard.layoutImageView(eventImage: UIImage(systemName: "photo"))
                    case .success(let image):
                        
                        self?.shakeView.eventCard.layoutImageView(eventImage: image)
                    }
                }
            }
        } else {
            self.shakeView.eventCard.layoutImageView(eventImage: UIImage(systemName: "photo"))
        }
      }
  
    
    override func becomeFirstResponder() -> Bool {
        return true
    }
    
    override func motionBegan(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
       
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
