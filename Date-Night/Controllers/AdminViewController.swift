//
//  AdminViewController.swift
//  Date-Night
//
//  Created by Phoenix McKnight on 2/23/20.
//  Copyright © 2020 Date Night Roulette. All rights reserved.
//

import UIKit
import FirebaseAuth


class AdminViewController: UIViewController {
    
    var arrayOfEvents = [Event]() {
        didSet {
            print("added Event  #\(arrayOfEvents.count)")
        }
    }
    
    var arrayOfYelpEvents = [Business]() {
        didSet {
            print("added Event  #\(arrayOfYelpEvents.count)")
        }
    }
    
    var arrayOfPreferences:[String] = [] {
        didSet {
            print(arrayOfPreferences.count)
        }
    }
    
    var prefList:[Categories] = [] {
        didSet {
            //    getPreferences()
        }
    }
    
    
    var fbEvents:[FBEvents] = [] {
        didSet {
            print("fbEvent count \(fbEvents.count)")
        }
    }
    
    
    let adminView = AdminView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .clear
        view.addSubview(adminView)
        addTargetToButtons()
        addDelegatesToSelf()
        getPreferences()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
    }
    
    
    @objc private func addEventsToFirebase() {
        sendEventToFireBase(eventArray: fbEvents)
    }
    
    private func getPreferences()  {
        guard let fileName = Bundle.main.path(forResource: "Categories", ofType: "json")
            else {fatalError()}
        let fileURL = URL(fileURLWithPath: fileName)
        do {
            let data = try Data(contentsOf: fileURL)
            let preferences = try
                JSONDecoder().decode(Wrapper.self, from: data)
            
            prefList = preferences.Categories
        } catch {
            fatalError("\(error)")
        }
    }
    
    private func addDelegatesToSelf() {
        adminView.preferenceCollectionView.delegate = self
        adminView.preferenceCollectionView.dataSource = self
    }
    private func addTargetToButtons() {
        adminView.addEventsButton.addTarget(self, action: #selector(addEventsToFirebase), for: .touchUpInside)
        
        adminView.getEventsFromAPIButton.addTarget(self, action: #selector(getAllEventsFromAPI), for: .touchUpInside)
    }
    
    @objc private func getAllEventsFromAPI() {
        getEventsFromAPI()
        getYelpEventsFromAPI()
     
    }
    
    private func getEventsFromAPI(){
        for preference in arrayOfPreferences {
            EventfulAPIClient.shared.getEventsFrom(category: preference) { (result) in
                
                switch result {
                    
                case .failure(let error):
                    print(error)
                case .success(let event):
                    // self.arrayOfEvents += event
                    self.convertEventsIntoFBEvents(events: event, preference: preference)
                }
            }
        }
    }
    
    private func getYelpEventsFromAPI(){
        for preference in arrayOfPreferences{
            YelpAPIClient.shared.getEventsFrom(category: preference) { (result) in
                switch result {
                case .failure(let error):
                    print(error)
                case .success(let event):
                    self.convertYelpEventsIntoFBEvents(events: event, preference: preference)
                }
            }
        }
    }

    private func convertEventsIntoFBEvents(events:[Event],preference:String) {
        for event in events {
            guard let description = event.description, let address = event.venue_address, let eventID = event.id, let title = event.title else {continue}
            
            let fbEvent = FBEvents(title: title, address: address, eventID: eventID, description: description, imageURL: event.image?.medium?.url ?? "Image Unavailable", websiteURL: event.venue_url ?? "URL Unavailable",type:preference)
            fbEvents.append(fbEvent)
            
        }
    }
    
    private func convertYelpEventsIntoFBEvents(events:[Business],preference:String) {
        for event in events {
//            guard let description = event.categories.first?.title else {}
//            guard let address = event.location.displayAddress.f else {}
//            guard let eventID = event.id else {}
//            guard let title = event.name
//                else {continue}
//
            let fbYelpEvent = FBEvents(title: event.name, address: event.location.returnDisplayAddress(), eventID: event.id, description: event.categories.first?.title.description, imageURL: event.imageURL ?? "Image Unavailable", websiteURL: event.url ?? "URL Unavailable", type: preference)
            fbEvents.append(fbYelpEvent)
            
        }
    }
    
    private func sendEventToFireBase(eventArray:[FBEvents]) {
        
        for event in eventArray {
            //                print(event.title)
            //                print(event.image?.medium.url ?? "no image")
            //                  guard event.description != nil else {return}
            //
            //                let fbEvent = FBEvents(title: event.title, address: event.venue_url, eventID: String(event.id), description: event.description, imageURL: event.image?.medium.url, websiteURL: event.venue_url,type:preference)
            //
            //
            
            FirestoreService.manager.sendEventsToFirebase(event: event) { (result) in
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
extension AdminViewController:UICollectionViewDataSource,UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        print(prefList.count)
        return prefList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let pref = prefList[indexPath.row]
        let cell = adminView.preferenceCollectionView.dequeueReusableCell(withReuseIdentifier: "PreferenceCell", for: indexPath) as! PreferenceCell
        cell.preferenceLabel.text = pref.data.type
        //cell.backgroundColor = #colorLiteral(red: 0.9164920449, green: 0.7743749022, blue: 0.9852260947, alpha: 1)
        cell.layer.cornerRadius = 5
        if arrayOfPreferences.contains(cell.preferenceLabel.text?.lowercased().replacingOccurrences(of: " ", with: "+") ?? "") {
            cell.isAddedToPreferenceArray = true
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let currentCell = collectionView.cellForItem(at: indexPath) as? PreferenceCell else {return}
        
        switch currentCell.isAddedToPreferenceArray {
        case true :
            currentCell.isAddedToPreferenceArray = false
            arrayOfPreferences.removeAll { (string) -> Bool in
                string == currentCell.preferenceLabel.text?.lowercased().replacingOccurrences(of: " ", with: "+") ?? ""
            }
        case false :
            currentCell.isAddedToPreferenceArray = true
            arrayOfPreferences.append(currentCell.preferenceLabel.text?.lowercased().replacingOccurrences(of: " ", with: "+") ?? "")
        }
        
        print("clicked")
    }
}
