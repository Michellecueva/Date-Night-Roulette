//
//  ShowEventViewController.swift
//  Date-Night
//
//  Created by Phoenix McKnight on 2/18/20.
//  Copyright © 2020 Michelle Cueva. All rights reserved.
//

import UIKit

class ShowEventVC: UIViewController {

    var arrayOfEvents = [Event]() {
        didSet {
            print("added Event  #\(arrayOfEvents.count)")
        }
    }
    var preferenceArray:[String] {
        guard let preferences =  UserDefaultsWrapper.standard.getPreferences() else {fatalError()}
        return preferences
    }
    
    
    var eventsLiked = [String]() {
        didSet {
            UserDefaultsWrapper.standard.store(eventsLikedArr: eventsLiked)
        }
    }
    
    lazy var button: UIButton = {
        let button = UIButton(frame:self.view.frame)
        button.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        button.addTarget(self, action: #selector(pressButton), for: .touchUpInside)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addSubview(button)
        clearEventsLikedArr()
 
    }
    
    @objc func pressButton() {
        likedButtonPressed()
    }
    
    private func likedButtonPressed() {
        getPriorEventsLiked()
        eventsLiked.append("hey")
        updateEventsLikedOnFirebase(eventsLiked: eventsLiked)
    }
    
    //needs a listener that listens to partner's event Liked arrary changing
    // whenever someone likes an event we need to be grabbing to events liked on user defaults, updating the stored events and also updating the events on firebase 
    
    private func getPriorEventsLiked() {
        if let eventsArr = UserDefaultsWrapper.standard.getEventsLiked() {
            eventsLiked = eventsArr
    }
        
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
    
    private func clearEventsLikedArr() {
        eventsLiked = []
        updateEventsLikedOnFirebase(eventsLiked: eventsLiked)
    }
}


//    private func addEventsFromAPI() {
//        for preference in preferenceArray {
//            SeatGeekAPIClient.shared.getEventsFrom(category: preference) { (result) in
//                switch result {
//                case .failure(let error):
//                    print(error)
//                case .success(let event):
//                    self.arrayOfEvents += event
//                    self.sendEventToFireBase(preference: preference, eventArray: event)
//                }
//            }
//        }
//    }
//    private func sendEventToFireBase(preference:String,eventArray:[Event]) {
//
//        for event in eventArray {
//
//            let fbEvent = FBEvents(title: event.title, address: event.venue.address, eventID: String(event.id), description: event.eventDescription, imageURL: nil, websiteURL: event.url,type:preference)
//
//            FirestoreService.manager.sendEventsToFirebase(event: fbEvent) { (result) in
//                switch result {
//                case .failure(let error):
//                    print(error)
//                case .success():
//                    print("added Event to firebase")
//                }
//            }
//    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

