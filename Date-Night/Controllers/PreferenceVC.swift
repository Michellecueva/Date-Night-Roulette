//
//  PreferencesVC.swift
//  Date-Night
//
//  Created by Krystal Campbell on 2/10/20.
//  Copyright © 2020 Michelle Cueva. All rights reserved.
//

import UIKit
import FirebaseAuth

class PreferenceVC: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    
    var prefView = PreferenceView()
    
    var arrayOfPreferences:[String] = [] {
        didSet {
            if arrayOfPreferences == initalArrayOfPreferences {
                prefView.saveButton.isEnabled = false
                
            }
        }
    }
    lazy var initalArrayOfPreferences:[String] = []
    
    var prefList = [Categories](){
        didSet{
            self.prefView.preferenceCollectionView.reloadData()
        }
    }
    
    var appUserID:String {
        guard let userID =  Auth.auth().currentUser?.uid else {fatalError("couldn't find userID")}
        return userID
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(prefView)
        collectionViewMethods()
        prefList = getPreferences()
        addObjcFunctionsToViewButton()
        self.navigationController?.navigationBar.topItem?.title = "Set your Preferences"
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getUserPreferences()
        prefView.saveButton.isEnabled = false
        
    }
    
    private func collectionViewMethods(){
        prefView.preferenceCollectionView.dataSource = self
        prefView.preferenceCollectionView.delegate = self
    }
    
    private func addObjcFunctionsToViewButton() {
        prefView.saveButton.addTarget(self, action: #selector(savedPressed(_:)), for: .touchUpInside)
    }
    
    @objc func savedPressed(_ sender: UIButton){
        // delegate?.eventFavs(tag: sender.tag)
       print("tapped button")
        
        FirestoreService.manager.savePreferencesForUser(field: .users, preferences: arrayOfPreferences, currentUserUID: appUserID) { (result) in
            switch result {
            case .failure(let error):
                print(error)
                print("couldn't save preferences")
            case .success():
                print("saved Preferences")
                
            }
        }
        print("button pressed!")
       
    }
    
    private func getPreferences() -> [Categories] {
        guard let fileName = Bundle.main.path(forResource: "Categories", ofType: "json")
            else {fatalError()}
        let fileURL = URL(fileURLWithPath: fileName)
        do {
            let data = try Data(contentsOf: fileURL)
            let preferences = try
                JSONDecoder().decode(Wrapper.self, from: data)
            
            return preferences.Categories
        } catch {
            fatalError("\(error)")
        }
    }
    
    
    private func getUserPreferences() {
        //determine whether or not we should make multiple requests to get the same user
        
        FirestoreService.manager.getUser(userID: appUserID) { (result) in
            switch result {
            case .failure(let error):
                print(error)
            case .success(let user):

                self.arrayOfPreferences = user.preferences
                self.initalArrayOfPreferences = user.preferences
                print(user.preferences.count)
                self.prefView.preferenceCollectionView.reloadData()
            }
        }
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        print(prefList.count)
        return prefList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let pref = prefList[indexPath.row]
        let cell = prefView.preferenceCollectionView.dequeueReusableCell(withReuseIdentifier: "PreferenceCell", for: indexPath) as! PreferenceCell
        cell.preferenceLabel.text = pref.data.type
        //cell.backgroundColor = #colorLiteral(red: 0.9164920449, green: 0.7743749022, blue: 0.9852260947, alpha: 1)
        cell.layer.cornerRadius = 5
        if arrayOfPreferences.contains(cell.preferenceLabel.text?.lowercased().replacingOccurrences(of: " ", with: "+") ?? "") {
            cell.isAddedToPreferenceArray = true
        } else {
            cell.isAddedToPreferenceArray = false
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let currentCell = collectionView.cellForItem(at: indexPath) as? PreferenceCell else {return}
        
        prefView.saveButton.isEnabled = true
        
        
        switch currentCell.isAddedToPreferenceArray {
        case true :
            
            arrayOfPreferences.removeAll { (string) -> Bool in
                string == currentCell.preferenceLabel.text?.lowercased().replacingOccurrences(of: " ", with: "+") ?? ""
                       }
            currentCell.isAddedToPreferenceArray = false
        case false :
          
            arrayOfPreferences.append(currentCell.preferenceLabel.text?.lowercased().replacingOccurrences(of: " ", with: "+") ?? "")
              currentCell.isAddedToPreferenceArray = true
        }
        
        print(arrayOfPreferences.count)
       }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width / 3.3, height: view.frame.width / 3.3)
        
    }
    
}
