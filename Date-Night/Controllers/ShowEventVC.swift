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
    
    var testpreferenceArray:[String] = ["nba"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
//addEventsFromAPI()
        // Do any additional setup after loading the view.
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
    }
//}
