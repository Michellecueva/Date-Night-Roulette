
import UIKit
import FirebaseFirestore


//shake gesture only works on first responder
class ShakeGestureVC: UIViewController {
    
    var eventIndexCount = 0
    
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
     
     var partnersEventsLiked = [String]()
     
     private var partnerListener: ListenerRegistration?
        
     private let db = Firestore.firestore()
     
     private var collectionReference:CollectionReference {
            return db.collection("users")
        }
      var count = 1
        
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
        addListenerOnPartner()
        getPriorEventsLiked()
    }
    
    override func viewDidAppear(_ animated:Bool) {
        super.viewDidAppear(animated)
      
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        clearEventsLikedArr()
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
    
   @objc private func likedButtonPressed() {
    guard let eventID = fbEvents.last?.eventID else {return}
    eventsLiked.append(eventID)
           updateEventsLikedOnFirebase(eventsLiked: eventsLiked)
           count += 1
           
           guard let lastEventLiked = eventsLiked.last else {return}
           if partnersEventsLiked.contains(lastEventLiked) {
               matchAlert(title: "It's a Match!", message: "You've Matched Events With Your Partner")
               // segue to the match VC
           }else {
            shakeView.confirmButton.isEnabled = false
    shakeTheEvent()
    }
    
       }

       
       private func getPriorEventsLiked() {
           if let eventsArr = UserDefaultsWrapper.standard.getEventsLiked() {
            guard eventsArr.count > 0 else {return}
        }
           
           //maybe pull events from firebase instead
           
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
           
           guard let partnerUID = UserDefaultsWrapper.standard.getPartnerUID() else {return}
           
           partnerListener = collectionReference.whereField("uid", isEqualTo: partnerUID)
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

                       print("listener on PartnerUser \(userList[0].eventsLiked)")
                       
                       self.partnersEventsLiked = userList[0].eventsLiked
                       
                   })
           }
    
    private func setUpView() {
      
        
        guard let lastEvent = self.fbEvents.last else {return}
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
