//
//  ViewController.swift
//  SwipingNavigation
//
//  Created by Andrew Overton on 2/10/20.
//  Copyright © 2020 Andrew Overton. All rights reserved.
//

import UIKit
import FirebaseAuth

class RootViewController: UIViewController {

  struct ViewControllerConfig {
    let viewController: UIViewController
    let leadingBarButtonItems: [UIBarButtonItem]
    let trailingBarButtonItems: [UIBarButtonItem]
  }
    lazy var homeScreenVC = HomeScreenVC()
    lazy var leftVC = LeftViewController()
    
    var invitesFromUser = [Invites]() {
        didSet {
            if invitesFromUser.count > 0 {
                leftVC.leftScreenStatus = .waitingForResponse
            } else {
                leftVC.leftScreenStatus = .sendInvite
            }
        }
    }
    
    
    
    private var currentUserEmail:String {
            guard let user = Auth.auth().currentUser?.email else {fatalError()}
                return user
            }
        

  let swipingNavigationViewController = SwipingContainerViewController()
  var viewControllerConfigs: [ViewControllerConfig] = [] // probably need to implement will set did set

  override func viewDidLoad() {
    super.viewDidLoad()
    getInvites()
    view.backgroundColor = .white
    setUpViewControllerConfigs()
    setUpSwipingNavigationViewController()
    swipingNavigationViewController.navigateToViewController(index: 1)
   showBarButtons(for: 1)
    }
  
  override func viewWillLayoutSubviews() {
    super.viewWillLayoutSubviews()
    swipingNavigationViewController.view.frame = view.bounds
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
  func setUpSwipingNavigationViewController() {
    swipingNavigationViewController.view.backgroundColor = .yellow
    swipingNavigationViewController.swipingViewControllerDelegate = self
    swipingNavigationViewController.viewControllers =
      viewControllerConfigs.map { $0.viewController }
    view.addSubview(swipingNavigationViewController.view)
  }
  
  func createFirstScreen() -> ViewControllerConfig {
    var vc = leftVC
    
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
//      self.navigationItem.leftBarButtonItem = config.leadingBarButtonItems.first
//      config.viewController.navigationItem.leftBarButtonItem = config.leadingBarButtonItems.first
//      guard let vc = view.superview?.next as? ViewController else { return }
  //    config.viewController.navigationItem.leftBarButtonItem = config.leadingBarButtonItems.first
  //  vc.navigationController?.navigationItem.leftBarButtonItem = config.leadingBarButtonItems.first
//      vc.navigationItem.leftBarButtonItem = config.leadingBarButtonItems.first
  //    config.viewController.navigationItem.leftBarButtonItem = config.leadingBarButtonItems.first

      
    }

    private func getInvites() {
           FirestoreService.manager.getAllInvites(searchField: .from, userEmailAddress: currentUserEmail) { [weak self](result) in
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

