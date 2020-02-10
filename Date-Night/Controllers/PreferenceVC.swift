//
//  PreferencesVC.swift
//  Date-Night
//
//  Created by Krystal Campbell on 2/10/20.
//  Copyright © 2020 Michelle Cueva. All rights reserved.
//

import UIKit

class PreferencesVC: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    
    var prefView = PreferencesView()
    
    var prefList = [Categories](){
        didSet{
            self.prefView.preferencesCollectionView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(prefView)
        collectionViewMethods()
    }
    
    private func collectionViewMethods(){
        prefView.preferencesCollectionView.dataSource = self
        prefView.preferencesCollectionView.delegate = self
    }
    
    @objc func savedPressed(_ sender: UIButton){
        // delegate?.eventFavs(tag: sender.tag)
        print("button pressed!")
        //sender.setBackgroundImage(UIImage(systemName: "heart.fill"), for: .normal)
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
        let cell = prefView.preferencesCollectionView.dequeueReusableCell(withReuseIdentifier: "preferenceCell", for: indexPath) as! preferenceCell
        cell.preferenceLabel.text = pref.data.type
        return cell
    }
    
}
