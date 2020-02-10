//
//  PreferencesVC.swift
//  Date-Night
//
//  Created by Krystal Campbell on 2/10/20.
//  Copyright © 2020 Michelle Cueva. All rights reserved.
//

import UIKit

class PreferenceVC: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    
    var prefView = PreferenceView()
    
    var prefList = [Categories](){
        didSet{
            self.prefView.preferenceCollectionView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(prefView)
        collectionViewMethods()
        prefList = getPreferences()
        self.navigationController?.navigationBar.topItem?.title = "Set your Preferences"
    }
    
    private func collectionViewMethods(){
        prefView.preferenceCollectionView.dataSource = self
        prefView.preferenceCollectionView.delegate = self
    }
    
    @objc func savedPressed(_ sender: UIButton){
        // delegate?.eventFavs(tag: sender.tag)
        print("button pressed!")
        sender.setBackgroundImage(UIImage(systemName: "heart.fill"), for: .normal)
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
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        print(prefList.count)
        return prefList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let pref = prefList[indexPath.row]
        let cell = prefView.preferenceCollectionView.dequeueReusableCell(withReuseIdentifier: "PreferenceCell", for: indexPath) as! PreferenceCell
        cell.preferenceLabel.text = pref.data.type
        cell.backgroundColor = #colorLiteral(red: 0.9164920449, green: 0.7743749022, blue: 0.9852260947, alpha: 1)
        cell.layer.cornerRadius = 5
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
           print("clicked")
       }
}
