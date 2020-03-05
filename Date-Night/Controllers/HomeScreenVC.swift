//
//  HomeScreenVC.swift
//  Date-Night
//
//  Created by Phoenix McKnight on 1/31/20.
//  Copyright © 2020 Michelle Cueva. All rights reserved.
//

import UIKit
import FirebaseFirestore
import FirebaseAuth

protocol ShakeGestureDelegate:AnyObject {
    func sendEvents(events:[FBEvents])
}
//change name of delegate
protocol TestChainDelegate:AnyObject {
    func sendEventDataToShakeVC(fbEvents:[FBEvents])
}

class HomeScreenVC: UIViewController {
    
     var homePageStatus:HomePageStatus = .none {
           didSet {
               determineHomepageVC()
           }
       }
 
    weak var delegate:TestChainDelegate?
    
  lazy var homeEvents:[FBEvents] = []
    
       private let pendingInvites = InvitesPendingVC()
       private let discoverEvents = DiscoverEventVC()
       private let preferences = PreferenceVC()
    
    var currentUser:AppUser? {
        didSet {
            
            print("homescreen received currentuser")
        discoverEvents.discoverEventCurrentUser = currentUser
        }
    }
      
       var partner:AppUser? {
           didSet {
            guard partner != nil else {return}
            print("homescreen received partner")
            discoverEvents.discoverEventsPartnerUser = partner
           }
       }
    
    private let shakeGesture = ShakeGestureVC()

    private var currentUserEmail:String {
        guard let user = Auth.auth().currentUser?.email else { fatalError()}
           
       return user
    }
    
  
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("Current User: \(currentUserEmail)")
      
    }
    
    
  
    private func addAndRemoveChild(currentChild:UIViewController) {
           for child in children {
               child.remove()
           }
        self.add(currentChild)
       }
    
        private func determineHomepageVC() {
            switch homePageStatus {

            case .discoverEvents:
               
                discoverEvents.delegate = self
                addAndRemoveChild(currentChild: discoverEvents)
                
            case .setPreferences:
                addAndRemoveChild(currentChild: preferences)
                
            case .shakeGesture:
               
                shakeGesture.fbEvents = homeEvents
                addAndRemoveChild(currentChild: shakeGesture)
                
                
            default:
                addAndRemoveChild(currentChild: pendingInvites)
            }
        }
    
    private func testChainDelegateFunction() {
        delegate?.sendEventDataToShakeVC(fbEvents: homeEvents)
    }
   
}

    extension HomeScreenVC:InvitesPendingDelegate {
        func changeStatus(status: HomePageStatus) {
            homePageStatus = status
        }
    }
    
extension HomeScreenVC:ShakeGestureDelegate {
    func sendEvents(events: [FBEvents]) {
        homeEvents = events
        testChainDelegateFunction()

    }
    
    
    
 
}
