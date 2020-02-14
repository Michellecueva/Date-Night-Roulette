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

class RootViewController: UIViewController {

    lazy var homeScreenVC = HomeScreenVC()
    lazy var leftVC = LeftViewController()
    
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
    
    var listOfInvites:[Invites] = [] {
           didSet {
               if listOfInvites.count >= 1 {
              // activateDelegate()
                print("it works")
               }
           }
       }
       
       var responseListener:ListenerRegistration?
    
    var collectionReference:Query = Firestore.firestore().collection("invites")
    
    private var currentUser:AppUser? {
        didSet {
    
            if currentUser?.preferences == [] && currentUser?.partnerEmail != "" {
                homeScreenVC.homePageStatus = .discoverEvents
            }
            
            if currentUser?.partnerEmail != "" {
                homeScreenVC.homePageStatus = .setPreferences
            }
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
   addInviteListener()
    getUser()
    getInvites()
    setUpViewControllerConfigs()
    setUpSwipingNavigationViewController()
 swipingNavigationViewController.navigateToViewController(index: 1)
   showBarButtons(for: 1)
    }
  
  override func viewWillLayoutSubviews() {
    super.viewWillLayoutSubviews()
    swipingNavigationViewController.view.frame = view.bounds
  }
    private func addInviteListener() {
         responseListener = collectionReference.whereField(
              "from",isEqualTo: userEmail).addSnapshotListener({ (snapshot, error) in
                  
                    if let error = error {
                                print(error.localizedDescription)
                            }
                            guard let invitesFromOnline = snapshot?.documents else {
                                print("no invites available")
                                return
                            }
                            let inviteList = invitesFromOnline.compactMap {  (snapshot) -> Invites? in
                                let inviteID = snapshot.documentID
                                let data = snapshot.data()
                              let invite = Invites(from: data, id: inviteID)
                              
                              if invite?.invitationStatus == "accepted" {
                                return invite
                              }
                                self.invitesFromUser.append(invite!)
                              return nil
                            }
            
                  self.listOfInvites = inviteList
                print("inviteList: \(inviteList.count)")
                  
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
    viewControllerConfigs = [
      createFirstScreen(),
      createSecondScreen(),
      createThirdScreen()
    ]
  }
private func setUpSwipingNavigationViewController() {
    
swipingNavigationViewController.swipingViewControllerDelegate = self
    swipingNavigationViewController.viewControllers =
      viewControllerConfigs.map { $0.viewController }
    view.addSubview(swipingNavigationViewController.view)
  }
  
  func createFirstScreen() -> ViewControllerConfig {
    let vc = leftVC
    
    //vc.view.backgroundColor = .red
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
    let vc = ProfileSettingVC()
    vc.view.backgroundColor = .clear
    let leadingBarButtonItems = [UIBarButtonItem(title: "blue", style: .plain
      , target: nil, action: nil)]
    let trailingBarButtonItems = [UIBarButtonItem(title: "bear", style: .plain
      , target: nil, action: nil)]
    return ViewControllerConfig(viewController: vc,
                                                                leadingBarButtonItems: leadingBarButtonItems,
                                                                trailingBarButtonItems: trailingBarButtonItems)
  }

  
    func showBarButtons(for page: Int) {
      print("landed on page \(page)")
      let config = viewControllerConfigs[page]
      navigationItem.setLeftBarButtonItems(config.leadingBarButtonItems, animated: true)
      navigationItem.setRightBarButtonItems(config.trailingBarButtonItems, animated: true)      
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
}
extension RootViewController: SwipingContainerViewControllerDelegate {
  func swipingViewControllerDidEndDeceleratingOnPage(swippingViewController: SwipingContainerViewController, page: Int) {
    showBarButtons(for: page)
  }
}

