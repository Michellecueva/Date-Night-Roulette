//
//  DiscoverEventVC.swift
//  Date-Night
//
//  Created by Kimball Yang on 2/6/20.
//  Copyright © 2020 Michelle Cueva. All rights reserved.
//

import UIKit
import FirebaseFirestore

class DiscoverEventVC: UIViewController {

    var discover = DiscoverEventView()
    
     weak var delegate:ShakeGestureDelegate?
    
    
    var discoverEventCurrentUser:AppUser? {
        didSet {
            print("discover event VC receieved currnetUser")
        }
    }
    
    private var partnerListener:ListenerRegistration?
    
   private var arrayOfEvents:[FBEvents] = []
      
    
    
    private var collectionReference:CollectionReference {
        return FirestoreService.manager.db.collection("users")
      }
    
    //dependency partner appuser
     var discoverEventsPartnerUser:AppUser? {
        didSet {
            print("discover event vc received partner")
            guard discoverEventsPartnerUser?.preferences.count ?? 0 > 0 else {return}
      discover.discoverEventButton.isEnabled = true
        }
    }
    
   
        
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        view.addSubview(discover)
        addObjcFunctions()
    }

    
    private func addObjcFunctions() {
        discover.myPreferencesButton.addTarget(self, action: #selector(goToPreferences), for: .touchUpInside)
        discover.randomEventButton.addTarget(self, action: #selector(goToRandomEvent), for: .touchUpInside)
        discover.discoverEventButton.addTarget(self, action: #selector(goToDiscoverEvent), for: .touchUpInside)
       }
       
     @objc private func goToPreferences() {

        present(PreferenceVC(), animated: true, completion: nil)
    }
    
    @objc private func goToRandomEvent() {

        present(RandomEventVC(), animated: true, completion: nil)
    }
    
    @objc private func goToDiscoverEvent() {

       
        getEvents(arrayOfPreferences: setPreferencesForGetEvent(user: discoverEventCurrentUser, partner: discoverEventsPartnerUser))
        
        let shakeGestureVC = ShakeGestureVC()
        shakeGestureVC.currentUser = discoverEventCurrentUser
    }
    
    
    private func shakeGestureDelegateFunction() {
       delegate?.sendEvents(events: arrayOfEvents)
    }
    
    private func setPreferencesForGetEvent(user:AppUser?, partner:AppUser?) -> Set<String> {
        guard let userPreferences = user?.preferences, let partnerPreferences = partner?.preferences else {fatalError()}
        
        let preferences = Set(userPreferences).intersection(Set(partnerPreferences))
                
        guard preferences.count > 0 else {return Set(partnerPreferences).union(Set(userPreferences))}
        return preferences
    }
    
    private func getEvents(arrayOfPreferences:Set<String>) {
      //check matched events to see stop events you've already added from showing up in get events
        let group = DispatchGroup()
        
        
        for preferences in arrayOfPreferences {
            group.enter()
            FirestoreService.manager.getEventsFromFireBase(preference: preferences) { [weak self] (result) in
                switch result {
                case .failure(let error):
                    print(error)
                    group.leave()
                case.success(let events):
                    self?.arrayOfEvents += events
                    group.leave()
                }
            }
        }
     
        group.notify(queue: .main) {
         
            self.shakeGestureDelegateFunction()
            self.remove()
        }
    }
}
