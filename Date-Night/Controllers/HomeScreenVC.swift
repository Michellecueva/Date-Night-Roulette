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

class HomeScreenVC: UIViewController {
    
     var homePageStatus:HomePageStatus = .none {
           didSet {
               determineHomepageVC()
           }
       }
    
       private let pendingInvites = InvitesPendingVC()
       private let discoverEvents = DiscoverEventVC()
       private let preferences = PreferenceVC()

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
               
                addAndRemoveChild(currentChild: discoverEvents)
                
            case .setPreferences:
                addAndRemoveChild(currentChild: preferences)
                
            default:
                addAndRemoveChild(currentChild: pendingInvites)
            }
        }
    }

    extension HomeScreenVC:InvitesPendingDelegate {
        func changeStatus(status: HomePageStatus) {
            homePageStatus = status
        }
   
    }
    
  

