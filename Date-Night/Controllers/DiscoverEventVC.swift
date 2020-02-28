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
    
    
    var currentUser:AppUser? {
        didSet{
            grabPartnerFromFirebase()
            
        }
    }
    
    private var partnerListener:ListenerRegistration?
    
   private var arrayOfEvents:[FBEvents] = []
      
    
    
    private var collectionReference:CollectionReference {
        return FirestoreService.manager.db.collection("users")
      }
    
    private var partner:AppUser? {
        didSet {
            guard partner?.preferences.count ?? 0 > 0 else {return}
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

       
        getEvents(arrayOfPreferences: setPreferencesForGetEvent(user: currentUser, partner: partner))
    }
    
    private func grabPartnerFromFirebase() {
        guard let partnerEmailAddress = currentUser?.partnerEmail else {fatalError()}
                FirestoreService.manager.getPartnersUserData(partnerEmailAddress: partnerEmailAddress) { [weak self](result) in
            switch result {
            case .failure(let error):
                print(error)
                
            case .success(let partner):
                self?.partner = partner[0]
                
                self?.addListener()
            }
        }
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
           // let shakeVC = ShakeGestureVC()
           // shakeVC.fbEvents = self.arrayOfEvents
            self.shakeGestureDelegateFunction()
           // self.partnerListener?.remove()

        }
       
    }
    private func addListener() {
                
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
}
