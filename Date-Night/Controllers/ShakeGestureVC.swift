//
//  ViewController.swift
//  TestShake
//
//  Created by Kimball Yang on 2/23/20.
//  Copyright © 2020 Kimball Yang. All rights reserved.
//



import UIKit

class ShakeGestureVC: UIViewController {
    
    var shakeView = ShakeGestureView()
    var dummyCell = ["SomeCell", "BadCell", "ThereminCell"]
    var collectionViewFlowLayout = UICollectionViewFlowLayout()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(shakeView)
        view.backgroundColor = .black
        shakeView.shakeCollectionView.delegate = self
        shakeView.shakeCollectionView.dataSource = self


    }
    



    
    
    override func motionBegan(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
        
        // Add code when motion begins -- probably could be some kind of animation
        
//        snapToNearestCell(shakeCollectionView)
        
    }
    
    override func motionEnded(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
        
        // Add code for when motion stops --
    }
    
    
    
    
    
}

extension ShakeGestureVC: UICollectionViewDelegate, UICollectionViewDataSource /*, UICollectionViewFlowLayout*/{
    
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dummyCell.count
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let shakeCell = collectionView.dequeueReusableCell(withReuseIdentifier: "ShakeCollectionCell", for: indexPath)
        shakeCell.backgroundColor = UIColor.blue
        return shakeCell
    }
    
//func snapToNearestCell(_ collectionView: UICollectionView) {
//
//    for i in 0..<collectionView.numberOfItems(inSection: 0) {
//
//        collectionViewFlowLayout.itemSize + collectionViewFlowLayout.minimumLineSpacing
//
//
//
//        let itemWithSpaceWidth = collectionViewFlowLayout.itemSize.width + collectionViewFlowLayout.minimumLineSpacing
//        let itemWidth = collectionViewFlowLayout.itemSize.width
//
//        if collectionView.contentOffset.x <= CGFloat(i) * itemWithSpaceWidth + itemWidth / 2 {
//            let indexPath = IndexPath(item: i, section: 0)
//            collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
//            break
//        }
//    }
//}
    
    
    
}




