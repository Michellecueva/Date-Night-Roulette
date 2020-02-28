//
//  AdminViewController.swift
//  Date-Night
//
//  Created by Phoenix McKnight on 2/23/20.
//  Copyright © 2020 Date Night Roulette. All rights reserved.
//

import UIKit


class AdminViewController: UIViewController {
    
    var arrayOfEvents = [Event]() {
         didSet {
             print("added Event  #\(arrayOfEvents.count)")
         }
     }
     var preferenceArray:[String] {
         guard let preferences =  UserDefaultsWrapper.standard.getPreferences() else {fatalError()}
         return preferences
     }
    

    let adminView = AdminView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .clear
        view.addSubview(adminView)
        addTargetToButton()
        
        // Do any additional setup after loading the view.
    }
    
    

    @objc private func addEventsToFirebase() {
     addEventsFromAPI()
    }
    
    private func addTargetToButton() {
        adminView.addEventsButton.addTarget(self, action: #selector(addEventsToFirebase), for: .touchUpInside)
    }
        private func addEventsFromAPI() {
            for preference in preferenceArray {
                EventfulAPIClient.shared.getEventsFrom(category: preference) { (result) in
                    switch result {
                    case .failure(let error):
                        print(error)
                    case .success(let event):
                        self.arrayOfEvents += event
                        self.sendEventToFireBase(preference: preference, eventArray: event)
                    }
                }
            }
        }
        private func sendEventToFireBase(preference:String,eventArray:[Event]) {
    
            for event in eventArray {
                
                  guard event.image?.medium.url != nil && event.description != nil else {return}
    
                let fbEvent = FBEvents(title: event.title, address: event.venue_url, eventID: String(event.id), description: event.description, imageURL: event.image?.medium.url, websiteURL: event.venue_url,type:preference)
    
              
               
                
                
                
                FirestoreService.manager.sendEventsToFirebase(event: fbEvent) { (result) in
                    switch result {
                    case .failure(let error):
                        print(error)
                    case .success():
                        print("added Event to firebase")
                    }
                }
        }
}
}
