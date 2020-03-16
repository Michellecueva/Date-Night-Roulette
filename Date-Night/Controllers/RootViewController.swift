//
//  ViewController.swift
//  SwipingNavigation
//
//  Created by Andrew Overton on 2/10/20.
//  Copyright © 2020 Andrew Overton. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseFirestore

class RootViewController: UIViewController{
    
    
    lazy var homeScreenVC = HomeScreenVC()
    lazy var leftVC = LeftViewController()
    lazy var profileVC = ProfileSettingVC()
    
    var pageControl:UIPageControl = UIPageControl(frame: CGRect(x: 0, y: 0, width: 0, height: 0)) {
        didSet {
            print("printing \(pageControl.currentPage)")
        }
    }
    
    var userEmail:String {
        guard let email = Auth.auth().currentUser?.email else {fatalError()}
        return email
    }
    
    private var profileButton:UIButton = {
        let profileBtn = UIButton(type: UIButton.ButtonType.custom)
     profileBtn.addTarget(self, action: #selector(navigateToProfileVC), for: .touchUpInside)
        return profileBtn
    }()
    
    private var invitesFromUser = [Invites]() {
        didSet {
            if invitesFromUser.count > 0 {
                leftVC.leftScreenStatus = .waitingForResponse
            } else {
                leftVC.leftScreenStatus = .sendInvite
            }
        }
    }
    
    
    private var partnerListener:ListenerRegistration?
    
    private var userListener:ListenerRegistration?
    
    private var collectionReference:Query = Firestore.firestore().collection("users")
    
     private var currentUser:AppUser? {
        didSet {
            setUpRightBarButton(profilePicURL: currentUser?.photoURL)
            handleAppNavigationLogic()
        }
    }
    
    private var currentUserEmail:String {
        guard let user = Auth.auth().currentUser?.email else {fatalError()}
        return user
    }
    
     
    
    
    private var partner:AppUser? {
       //handle removing partner profile image after a user removes their partner
        didSet {
               print("rootVC received partner")
            
            guard partner != nil else {return}
               leftVC.leftScreenPartner = partner
               homeScreenVC.partner = partner
            setUpLeftBarButton(profilePictureURL: partner?.photoURL)
            
           }
       }
    
    private let swipingNavigationViewController = SwipingContainerViewController()
    private var viewControllerConfigs: [ViewControllerConfig] = [] // probably need to implement will set did set
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getUser()
        makeNavBarTranslucent()
        showBarButtons()
       
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        swipingNavigationViewController.view.frame = view.bounds
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        guard currentUser != nil else {return}
        handleAppNavigationLogic()
        
    }
    
    private func handleAppNavigationLogic() {
        if currentUser?.partnerEmail == "" {
            getInvites()
            homeScreenVC.homePageStatus = .none
            partner = nil
            profileVC.currentUser = currentUser

        } else {
            if partner == nil {
                grabPartnerFromFirebase()
            }
            profileVC.currentUser = currentUser
            leftVC.leftScreenStatus = .partnerProfile
            homeScreenVC.currentUser = currentUser
            
            if currentUser?.preferences != [] {
                homeScreenVC.homePageStatus = .discoverEvents
                
            } else {
                homeScreenVC.homePageStatus = .setPreferences
            }
        }

    }
    
   
    private func setUpLeftBarButton(profilePictureURL:String?) {
        guard let partnerURL = profilePictureURL else {return}
       
            if let image = ImageHelper.shared.image(forKey: partnerURL as NSString) {
                
                self.navigationItem.leftBarButtonItem = UIBarButtonItem.barButton(self, action: #selector(self.navigateToPartnerVC), imageName: nil, image: image, systemImageName: nil)
                self.navigationItem.leftBarButtonItem?.customView?.layer.cornerRadius = 14
                self.navigationItem.leftBarButtonItem?.customView?.layer.masksToBounds = true
                
                self.navigationItem.leftBarButtonItem?.customView?.layoutIfNeeded()
                                   
            } else {
        
                
        ImageHelper.shared.getImage(urlStr: partnerURL) { [weak self] (result) in
           
            switch result {
            case .failure(let error):
                print(error)
            case .success(let image):
                DispatchQueue.main.async {
                self?.navigationItem.leftBarButtonItem = UIBarButtonItem.barButton(self, action: #selector(self?.navigateToPartnerVC), imageName: nil, image: image, systemImageName: nil)
                self?.navigationItem.leftBarButtonItem?.customView?.layer.cornerRadius = 14
                self?.navigationItem.leftBarButtonItem?.customView?.layer.masksToBounds = true
                    
                    self?.navigationItem.leftBarButtonItem?.customView?.layoutIfNeeded()
                    
               
            }
                }
        }
        }
    }
    
    private func setUpRightBarButton(profilePicURL:String?) {
        guard let profileURL = profilePicURL else {return}
        
        if let image = ImageHelper.shared.image(forKey: profileURL as NSString) {
                     
            self.navigationItem.leftBarButtonItem = UIBarButtonItem.barButton(self, action: #selector(self.navigateToPartnerVC), imageName: nil, image: image, systemImageName: nil)
            self.navigationItem.rightBarButtonItem?.customView?.layer.cornerRadius = 14
            self.navigationItem.rightBarButtonItem?.customView?.layer.masksToBounds = true
            
            self.navigationItem.rightBarButtonItem?.customView?.layoutIfNeeded()
                               
        } else {
        
        ImageHelper.shared.getImage(urlStr: profileURL) { [weak self] (result) in
            DispatchQueue.main.async {
                
            
                   switch result {
                   case .failure(let error):
                       print(error)
                   case .success(let image):
                    
                    self?.navigationItem.rightBarButtonItem = UIBarButtonItem.barButton(self, action: #selector(self?.navigateToProfileVC), imageName: nil, image: image, systemImageName: nil)
                    self?.navigationItem.rightBarButtonItem?.customView?.layer.cornerRadius = 14
                    self?.navigationItem.rightBarButtonItem?.customView?.layer.masksToBounds = true
                    
                    self?.navigationItem.rightBarButtonItem?.customView?.layoutIfNeeded()
                    
                }
                }
               }
        }
    }

    
    private func addUserListener() {
        userListener = collectionReference.whereField(
            "email",isEqualTo: userEmail).addSnapshotListener({ (snapshot, error) in
                
                if let error = error {
                    print(error.localizedDescription)
                }
                guard let usersFromOnline = snapshot?.documents else {
                    print("no users available")
                    return
                }
                let userList = usersFromOnline.compactMap {  (snapshot) -> AppUser? in
                    let userID = snapshot.documentID
                    let data = snapshot.data()
                    let user = AppUser(from: data, id: userID)
                    
                    return user
                }
                if userList.last?.partnerEmail == "" {
                    self.partner = nil
                }
                self.currentUser = userList.last
            })
    }
    
     private func addPartnerListener() {
                    
         partnerListener = collectionReference.whereField("uid", isEqualTo: partner!.uid).addSnapshotListener({ (snapshot, error) in
            if let error = error {
                print(error.localizedDescription)
            }
            guard let userFromOnline = snapshot?.documents else {
                print("couldn't attach snapshot")
                return
            }
            let userList = userFromOnline.compactMap { (snapshot) -> AppUser? in
                let userID = snapshot.documentID
                let data = snapshot.data()
                return AppUser(from: data, id: userID)
            }
            self.partner = userList[0]
        })
        }
        deinit {
            self.partnerListener?.remove()
    }
    
    private func getUser() {
        guard let userID = Auth.auth().currentUser?.uid else {return}
        FirestoreService.manager.getUser(userID:userID) { [weak self] (result) in
            switch result{
            case .failure(let error):
                print(error)
            case .success(let user):
                self?.currentUser = user
                self?.addUserListener()
                self?.setUpViewControllerConfigs()
                self?.setUpSwipingNavigationViewController()
                self?.configurePageControl()
                self?.swipingNavigationViewController.setStartingViewController()

            }
        }
    }
    
    private func grabPartnerFromFirebase() {
           guard let partnerEmailAddress = currentUser?.partnerEmail else {fatalError()}
                   FirestoreService.manager.getPartnersUserData(partnerEmailAddress: partnerEmailAddress) { [weak self](result) in
               switch result {
               case .failure(let error):
                   print(error)
                   
               case .success(let partner):
                   self?.partner = partner[0]
                   self?.addPartnerListener()
               }
           }
       }

    func positionSwipingViewController() {
        let minY = navigationController?.navigationBar.frame.maxX ?? 0
        let frame =
            CGRect(x: 0,
                   y: minY,
                   width: view.bounds.width,
                   height: view.bounds.height - minY)
        swipingNavigationViewController.view.frame = frame
    }
    
    func setUpViewControllerConfigs() {
        
        if currentUser?.isAdmin == false {
            viewControllerConfigs = [
                      createFirstScreen(),
                      createSecondScreen(),
                      createThirdScreen()
                  ]
        } else {
            viewControllerConfigs = [
                      createFirstScreen(),
                      createSecondScreen(),
                      createThirdScreen(),
                       createAdminPage()
                  ]
        }
        
      
    }
    private func setUpSwipingNavigationViewController() {
        swipingNavigationViewController.swipingViewControllerDelegate = self
        swipingNavigationViewController.viewControllers =
            viewControllerConfigs.map { $0.viewController }
        view.addSubview(swipingNavigationViewController.view)
    }
    
    func createFirstScreen() -> ViewControllerConfig {
        let vc = leftVC
        let leadingBarButtonItems = [UIBarButtonItem(title: "red", style: .plain
            , target: nil, action: nil)]
        let trailingBarButtonItems = [UIBarButtonItem(title: "cat", style: .plain
            , target: nil, action: nil)]
        return ViewControllerConfig(viewController: vc,
                                    leadingBarButtonItems: leadingBarButtonItems,
                                    trailingBarButtonItems: trailingBarButtonItems)
    }
    
    func createSecondScreen() -> ViewControllerConfig {
        let vc = homeScreenVC
        vc.delegate = self
        vc.view.backgroundColor = .white
        let leadingBarButtonItems = [UIBarButtonItem(title: "yellow", style: .plain
            , target: nil, action: nil)]
        let trailingBarButtonItems = [UIBarButtonItem(title: "dog", style: .plain
            , target: nil, action: nil)]
        
        return ViewControllerConfig(viewController: vc,
                                    leadingBarButtonItems: leadingBarButtonItems,
                                    trailingBarButtonItems: trailingBarButtonItems)
    }
    
    func createThirdScreen() -> ViewControllerConfig {
        let vc = profileVC
        profileVC.currentUser = currentUser
        vc.view.backgroundColor = .clear
        let leadingBarButtonItems = [UIBarButtonItem(title: "blue", style: .plain
            , target: nil, action: nil)]
        let trailingBarButtonItems = [UIBarButtonItem(title: "bear", style: .plain
            , target: nil, action: nil)]
        return ViewControllerConfig(viewController: vc,
                                    leadingBarButtonItems: leadingBarButtonItems,
                                    trailingBarButtonItems: trailingBarButtonItems)
    }
    
    private func createAdminPage() -> ViewControllerConfig {
        let vc = AdminViewController()
               vc.view.backgroundColor = .clear
               let leadingBarButtonItems = [UIBarButtonItem(title: "blue", style: .plain
                   , target: nil, action: nil)]
               let trailingBarButtonItems = [UIBarButtonItem(title: "bear", style: .plain
                   , target: nil, action: nil)]
               return ViewControllerConfig(viewController: vc,
                                           leadingBarButtonItems: leadingBarButtonItems,
                                           trailingBarButtonItems: trailingBarButtonItems)
    }
    
    
    func configurePageControl() {
        self.pageControl.numberOfPages = viewControllerConfigs.count
        self.pageControl.currentPage = 1
        self.pageControl.tintColor = #colorLiteral(red: 0.9164920449, green: 0.7743749022, blue: 0.9852260947, alpha: 1)
        self.pageControl.pageIndicatorTintColor = UIColor.white
        self.pageControl.currentPageIndicatorTintColor = #colorLiteral(red: 0.9767183661, green: 0.2991916835, blue: 1, alpha: 1)
        pageControl.isUserInteractionEnabled = false
        pageControl.translatesAutoresizingMaskIntoConstraints = false
        
        navigationItem.titleView = pageControl
      //  pageControl.transform = CGAffineTransform(scaleX: 1.5, y: 1.5)
        
    }
  
   private func showBarButtons() {
    navigationItem.leftBarButtonItem = UIBarButtonItem.barButton(self, action: #selector(navigateToPartnerVC), imageName: nil, image: nil,systemImageName:"person.fill")
     navigationItem.rightBarButtonItem = UIBarButtonItem.barButton(self, action: #selector(navigateToProfileVC), imageName: nil, image: nil,systemImageName:"person.fill")
    }
    
    
    private func getInvites() {
        
        FirestoreService.manager.getAllInvites( inviteField: .from, userEmailAddress: currentUserEmail) { [weak self](result) in
            switch result {
            case .failure(let error):
                print(error)
            case .success(let invites):
                self?.invitesFromUser = invites
            }
        }
    }
    
    @objc func navigateToPartnerVC() {

        swipingNavigationViewController.navigateToViewController(index: 0)
        pageControl.currentPage = 0
        navigationItem.rightBarButtonItem?.isEnabled = false
        navigationItem.leftBarButtonItem?.isEnabled = false
    }
    
    @objc func navigateToProfileVC() {
        swipingNavigationViewController.navigateToViewController(index: 2)
        pageControl.currentPage = 2
        navigationItem.rightBarButtonItem?.isEnabled = false
        navigationItem.leftBarButtonItem?.isEnabled = false
    }
}
extension RootViewController: SwipingContainerViewControllerDelegate {
    func swipingViewControllerDidEndDeceleratingOnPage(swippingViewController: SwipingContainerViewController, page: Int) {
        print(page)
        pageControl.currentPage = page
        if page == 0 || page == 2 {
            navigationItem.rightBarButtonItem?.isEnabled = false
            navigationItem.leftBarButtonItem?.isEnabled = false
        } else {
                       navigationItem.rightBarButtonItem?.isEnabled = true
                       navigationItem.leftBarButtonItem?.isEnabled = true

        }
    }
}

extension RootViewController:fbEventsDelegate {
    func sendEventDataToShakeVC(fbEvents: [FBEvents]) {
        let shakeVC = ShakeGestureVC()
     //maybe pop discover VC before pushing shakeVC
        shakeVC.fbEvents = fbEvents
        navigationController?.pushViewController(shakeVC, animated: true)
    }
}
