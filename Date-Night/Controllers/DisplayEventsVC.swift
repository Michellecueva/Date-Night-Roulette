
import UIKit
import FirebaseFirestore
import FirebaseAuth
//import UserNotifications




class DisplayEventsVC: UIViewController {
    
    var eventIndexCount = 0
    
    var event: FBEvents!
    var storedEvents:[FBEvents] = []
    var displayEventView = DisplayEventView()
    var fbEvents:[FBEvents] = []
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
        view.addSubview(displayEventView)
        view.backgroundColor = .black
       // UNUserNotificationCenter.current().delegate = self
        
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
        setInitialCards()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
    }
    
    
    private func enqueueAndDequeue(card:EventCard) {
        
        displayEventView.eventCard.queue.remove(at: 0)
        guard displayEventView.eventCard.queue.count < fbEvents.count else {
            setCards()
            return}
        displayEventView.eventCard.queue.append(card)
        
        displayEventView.eventCard.insertSubview(card, at: 0)
        setCards()
       // card.layer.borderColor = .none
       // card.layer.borderWidth = 0
    }
    
    private func setCards() {
        //implement check if number of events is **initially** lower than the number of eventCards
        
        guard displayEventView.eventCard.queue.count - 1 > 0 else {
            self.showAlert(title: "No more events", message: "What should we put here?")
            return}
        for card in 0...displayEventView.eventCard.queue.count - 1 {
            switch card {
            case 0:
                displayEventView.eventCard.firstCard = displayEventView.eventCard.queue[card]
                storedEvents.remove(at: 0)
                
                if  displayEventView.eventCard.queue[card].gestureRecognizers?.count ?? 1 < 2 {
                    displayEventView.eventCard.queue[card].addGestureRecognizer(panGestureRecognizer)
                }
                
                displayEventView.eventCard.queue[card].isUserInteractionEnabled = true
            case 1:
                displayEventView.eventCard.secondCard = displayEventView.eventCard.queue[card]
                if displayEventView.eventCard.queue.count == 2 {
                    setUpView(event: fbEvents.popLast(), card: displayEventView.eventCard.queue[card])
                }
                
                displayEventView.eventCard.queue[card].isUserInteractionEnabled = false
            case 2:
                displayEventView.eventCard.thirdCard = displayEventView.eventCard.queue[card]
                
                setUpView(event: fbEvents.popLast(), card: displayEventView.eventCard.queue[card])
                displayEventView.eventCard.queue[card].isUserInteractionEnabled = false
            default:
                print("")
            }
        }
    }
    
    private func setInitialCards() {
        guard displayEventView.eventCard.queue.count - 1 > 0 else {return}
        for card in 0...displayEventView.eventCard.queue.count - 1 {
            switch card {
            case 0:
                displayEventView.eventCard.firstCard = displayEventView.eventCard.queue[card]
                
                if  displayEventView.eventCard.queue[card].gestureRecognizers?.count ?? 1 < 2 {
                    displayEventView.eventCard.queue[card].addGestureRecognizer(panGestureRecognizer)
                    
                }
                setUpView(event: fbEvents.popLast(), card: displayEventView.eventCard.queue[card])
                displayEventView.eventCard.queue[card].isUserInteractionEnabled = true
            case 1:
                displayEventView.eventCard.secondCard = displayEventView.eventCard.queue[card]
                
                setUpView(event: fbEvents.popLast(), card: displayEventView.eventCard.queue[card])
                displayEventView.eventCard.queue[card].isUserInteractionEnabled = false
            case 2:
                displayEventView.eventCard.thirdCard = displayEventView.eventCard.queue[card]
                
                setUpView(event: fbEvents.popLast(), card: displayEventView.eventCard.queue[card])
                displayEventView.eventCard.queue[card].isUserInteractionEnabled = false
            default:
                print("")
            }
        }
    }
    
    private func addObjcFunctionsToViewButtons() {
        displayEventView.confirmButton.addTarget(self, action: #selector(likedButtonPressed), for: .touchUpInside)
    }
    
    @objc private func panGesture(sender:UIPanGestureRecognizer)
        
    {
        
        let card = sender.view
        let pointer = sender.translation(in: view)
        
        //      uncomment when bug is fixed -view.center.y makes the card move to the bottom of the screen-
        //        card?.center = CGPoint(x: view.center.x + pointer.x, y: view.center.y + pointer.y)
        
        card?.center.x = view.center.x + pointer.x
        
        let xFromCenter = (card?.center.x)! - view.center.x
        let rotation = (xFromCenter / (view.frame.width / 2)) * 0.93
        // for full rotation make sure rotation value is over 1 (divide xFromCenter seperately)
        let distanceFromCenterToTheRight = view.center.x  * 0.50
        
        let distanceFromCenterToTheLeft = view.center.x * -0.50
        
        let scaler = min(abs(80/xFromCenter), 1)
        
        card?.transform = CGAffineTransform(rotationAngle: rotation).scaledBy(x: scaler, y: scaler)
        
        if xFromCenter > 0 {
            card?.layer.borderWidth = 2
            card?.layer.borderColor = UIColor.green.withAlphaComponent(abs(xFromCenter / view.center.x)).cgColor
            
            // displayEventView.eventCard.secondCard?.transform = CGAffineTransform(translationX: <#T##CGFloat#>, y: <#T##CGFloat#>)
            
        } else if xFromCenter < 0 {
            card?.layer.borderWidth = 2
            card?.layer.borderColor = UIColor.red.withAlphaComponent(abs(xFromCenter / view.center.x)).cgColor
        }
        
        if sender.state == .ended {
            
            if xFromCenter > 0 && xFromCenter < distanceFromCenterToTheRight {
                
                UIView.animate(withDuration: 0.2) {
                    
                    card?.center.x = self.view.center.x
                 //   card?.layer.borderWidth = 0
                  //  card?.layer.borderColor = .none
                    card?.transform = .identity
                    card?.layer.borderColor = StyleGuide.AppColors.primaryColor.cgColor
                }
                return
            } else if xFromCenter < 0 && xFromCenter > distanceFromCenterToTheLeft {
                
                UIView.animate(withDuration: 0.2) {
                    card?.center.x = self.view.center.x
                   // card?.layer.borderWidth = 0
                  //  card?.layer.borderColor = .none
                    card?.transform = .identity
 card?.layer.borderColor = StyleGuide.AppColors.primaryColor.cgColor
                }
                return
            } else if xFromCenter >= distanceFromCenterToTheRight {
                
                UIView.animate(withDuration: 0.5, animations: {
                    card?.center = CGPoint(x: self.view.frame.maxX + (self.view.frame.width * 0.5), y: (card?.center.y)! + (card?.superview?.frame.height)! * 0.05)
                })
                likedButtonPressed()
                if self.displayEventView.eventCard.queue.count < self.fbEvents.count {
                    self.enqueueAndDequeue(card: card as! EventCard)
                    
                } else {
                    enqueueAndDequeue(card: card as! EventCard)
                    card?.removeFromSuperview()
                }
                return
            } else if xFromCenter <= distanceFromCenterToTheLeft
            {
                UIView.animate(withDuration: 0.5, animations: {
                    
                    card?.center = CGPoint(x: self.view.frame.maxX - (self.view.frame.width * 1.5), y: ((card?.center.y)!) + (card?.superview?.frame.height)! * 0.05)
                })
                if self.displayEventView.eventCard.queue.count < self.fbEvents.count {
                    
                    self.enqueueAndDequeue(card: card as! EventCard)
                    
                } else {
                    enqueueAndDequeue(card: card as! EventCard)
                    card?.removeFromSuperview()
                }
                return
            }
        }
    }
    
    @objc private func likedButtonPressed() {
        
        guard let lastEvent = storedEvents.first else {return}
        event = lastEvent
        eventsLiked.append(event.eventID)
        updateEventsLikedOnFirebase(eventsLiked: eventsLiked)
        guard let lastEventLiked = eventsLiked.last else {return}
        if partnersEventsLiked.contains(lastEventLiked) {
            guard let coupleID = currentUser?.coupleID else {return}
            let eventTitle = event.title == "" ? "Title Unavailable" : event.title!
            let matchedEvent = MatchedEvent(coupleID: coupleID, title: eventTitle, eventID: event.eventID, address: event.address, description: event.description, imageURL: event.imageURL, websiteURL: event.websiteURL, type: event.type)
            createMatchedEvent(matchedEvent: matchedEvent)
            segueToMatchedVC()
            
            matchAlert(title: "It's a Match!", message: "You've Matched Events With Your Partner")
            clearEventsLikedArr()
            
        }else {
           
        }
    }
    
    private func getPriorEventsLiked() {
        if let eventsArr = UserDefaultsWrapper.standard.getEventsLiked() {
            guard eventsArr.count > 0 else {return}
        }
    }
    
    private func getAppUser() {
        guard let user = Auth.auth().currentUser else {return}
        FirestoreService.manager.getUser(userID: user.uid) { (result) in
            switch result {
            case .success(let appUser):
                self.currentUser = appUser
            case .failure(let error):
                print("unable to get appUser in DisplayEventVC \(error)")
            }
        }
    }
    
    private func updateHasMatchedField(hasMatched: Bool) {
        FirestoreService.manager.updateCurrentUser(hasMatched: hasMatched) { (result) in
            switch result {
            case .success(()):
                print("Has Matched has changed")
            case .failure(let error):
                print("Unable to change Has Matched field \(error)")
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
        FirestoreService.manager.createMatchedEvent(matchedEvent: matchedEvent) { [weak self] (result) in
            switch result {
            case .success(()):
                print("able to save matched event")
                self?.updateHasMatchedField(hasMatched: true)

            case .failure(let error):
                print("not able to save matched event \(error)")
            }
        }
    }
    
    private func segueToMatchedVC() {
        let matched = MatchedEventVC()
        matched.newImage = self.displayEventView.eventCard.firstCard?.imageView.image
        matched.event = self.event
        self.navigationController?.pushViewController(matched, animated: true)
        updateHasMatchedField(hasMatched: false)
        
    }
    
    private func matchAlert(title:String,message:String) {
        //move to extension
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let confirmMatch = UIAlertAction(title: "Confirm", style: .default) { (response) in
            
            let matched = MatchedEventVC()
            matched.newImage = self.displayEventView.eventCard.firstCard?.imageView.image
            matched.event = self.event
            self.navigationController?.pushViewController(matched, animated: true)
            
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
                guard let usersFromOnline = snapshot?.documents else {return}
                let userList = usersFromOnline.compactMap { (snapshot) -> AppUser? in
                    let userID = snapshot.documentID
                    let data = snapshot.data()
                    return AppUser(from: data, id: userID)
                }
                self.partnersEventsLiked = userList[0].eventsLiked
                
                if userList[0].hasMatched == true {
                    // push notification sent instead of alert
                    
//                    UNNotification.configureNotifications(title: "It's a Match!", body: "You've Matched Events With Your Partner", time: 0.1, categoryIdentifier: "matched")
                    
                    self.matchAlert(title: "It's a Match!", message: "You have a match")
                }
            })
    }
    private func setUpView(event:FBEvents?,card:EventCard?) {
        guard let event = event else {return}
        storedEvents.append(event)
        card?.layoutTitleLabel(event: event)
        card?.layoutDetailView(from:event)
        //   card?.storeRelevantData(from: event)
        if let image = event.imageURL {
            
            //remember to stop user interaction until image finishes loading
            ImageHelper.shared.getImage(urlStr: image) { (result) in
                DispatchQueue.main.async {
                 
                    switch result {
                    case .failure(let error):
                        print(error)
                        card?.layoutImageView(eventImage: UIImage(systemName: "photo.fill"))
                    case .success(let image):
                        
                        card?.layoutImageView(eventImage: image)
                    }
                }
            }
        } else {
            card?.layoutImageView(eventImage: UIImage(systemName: "photo.fill"))
        }
    }
}
//extension DisplayEventsVC: UNUserNotificationCenterDelegate {
//    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
//        completionHandler([.alert, .sound])
//    }
//    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
//        let matched = MatchedEventVC()
//        matched.newImage = self.displayEventView.eventCard.firstCard?.imageView.image
//        matched.event = self.event
//        self.navigationController?.pushViewController(matched, animated: true)
//    }
//}
