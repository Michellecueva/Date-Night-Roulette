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
    
    var pageControl:UIPageControl = UIPageControl(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
    
    var userEmail:String {
        guard let email = Auth.auth().currentUser?.email else {fatalError()}
        return email
    }
    
    private var invitesFromUser = [Invites]() {
        didSet {
            if invitesFromUser.count > 0 {
                leftVC.leftScreenStatus = .waitingForResponse
            } else {
                leftVC.leftScreenStatus = .sendInvite
            }
        }
    }
    
    
    
    
    var userListener:ListenerRegistration?
    
    var collectionReference:Query = Firestore.firestore().collection("users")
    
     private var currentUser:AppUser? {
        didSet {
            print("changed")
            
            if currentUser?.partnerEmail == "" {
                getInvites()
                homeScreenVC.homePageStatus = .none
            } else {
                leftVC.currentUser = currentUser
                profileVC.currentUser = currentUser
                leftVC.leftScreenStatus = .partnerProfile
                if currentUser?.preferences != [] {
                    homeScreenVC.homePageStatus = .discoverEvents
                    
                } else {
                    homeScreenVC.homePageStatus = .setPreferences
                }
            }
            
//
//            if currentUser?.preferences != [] && currentUser?.partnerEmail != "" {
//
//                homeScreenVC.homePageStatus = .discoverEvents
//                leftVC.leftScreenStatus = .partnerProfile
//                  leftVC.currentUser = currentUser
//            } else if currentUser?.preferences == [] && currentUser?.partnerEmail != "" {
//                homeScreenVC.homePageStatus = .setPreferences
//                leftVC.leftScreenStatus = .partnerProfile
//                profileVC.currentUser = currentUser
//                leftVC.currentUser = currentUser
//            } else if currentUser?.partnerEmail == "" {
//                getInvites()
//                homeScreenVC.homePageStatus = .none
//            }
//        }
        }
    }
    
    private var currentUserEmail:String {
        guard let user = Auth.auth().currentUser?.email else {fatalError()}
        return user
    }
    
    
    private let swipingNavigationViewController = SwipingContainerViewController()
    private var viewControllerConfigs: [ViewControllerConfig] = [] // probably need to implement will set did set
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        getUser()
        setUpViewControllerConfigs()
        setUpSwipingNavigationViewController()
        configurePageControl()
        makeNavBarTranslucent()
swipingNavigationViewController.setStartingViewController()
        showBarButtons()
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        swipingNavigationViewController.view.frame = view.bounds
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
                self.currentUser = userList.last
                print(self.currentUser?.email)
                
            })
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
        pageControl.transform = CGAffineTransform(scaleX: 1.5, y: 1.5)
        
    }
  
    func showBarButtons() {
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .rewind, target: self, action:#selector(backwards) )
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .fastForward, target: self, action: #selector(forwards))
    }
    
    @objc private func backwards() {
        guard pageControl.currentPage != 0 else {return}
        pageControl.currentPage -= 1
        
        swipingNavigationViewController.navigateToViewController(index: (pageControl.currentPage))
    }
    
    @objc private func forwards() {
        guard pageControl.currentPage != 2 else {return}
        pageControl.currentPage += 1
       
       
        swipingNavigationViewController.navigateToViewController(index: pageControl.currentPage)
       
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
    
    @objc func pageControlTapHandler(sender:UIPageControl) {
        print("currentPage:", sender.currentPage)
       
        swipingNavigationViewController.navigateToViewController(index: sender.currentPage)
        //currentPage: 1
    }
}
extension RootViewController: SwipingContainerViewControllerDelegate {
    func swipingViewControllerDidEndDeceleratingOnPage(swippingViewController: SwipingContainerViewController, page: Int) {
        print(page)
        pageControl.currentPage = page
    
        
    }
    
}



