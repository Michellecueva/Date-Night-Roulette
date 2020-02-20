//
//  ShakeGestureVC.swift
//  Date-Night
//
//  Created by Kimball Yang on 2/18/20.
//  Copyright © 2020 Michelle Cueva. All rights reserved.
//

import UIKit

class ShakeGestureVC: UIViewController {
    
    var shakeView = ShakeGestureView()
    var dummyCell = ["SomeCell", "BadCell", "ThereminCell"]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(shakeView)
        view.backgroundColor = .black
        shakeView.shakeCollectionView.delegate = self
        shakeView.shakeCollectionView.dataSource = self
    }
    
    override func motionBegan(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
        
        // Add code when motion begins -- probably could be some kind of animation
    }
    
    override func motionEnded(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
        
        // Add code for when motion stops -- 
    }
    
    
    
    
}

extension ShakeGestureVC: UICollectionViewDelegate, UICollectionViewDataSource {
    
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dummyCell.count
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let shakeCell = collectionView.dequeueReusableCell(withReuseIdentifier: "ShakeCollectionCell", for: indexPath)
        shakeCell.backgroundColor = UIColor.blue
        return shakeCell
    }
    
    
    
    
}
