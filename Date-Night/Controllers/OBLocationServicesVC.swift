//
//  OBLocationServicesVC.swift
//  Date-Night
//
//  Created by Krystal Campbell on 3/20/20.
//  Copyright © 2020 Date Night Roulette. All rights reserved.
//

import UIKit

class OBLocationServicesVC: UIViewController {

     let obLocations = OBLocationServicesView()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(obLocations)
       // setupScene()

        // Do any additional setup after loading the view.
    }
    
//    private func setupScene(){
//
//           self.navigationController?.navigationBar.topItem?.title = "Date Night Roulette"
//           navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Skip", style: .plain, target: self, action: #selector(skipButton))
//           self.navigationController?.navigationBar.barTintColor = .darkGray
//           navigationItem.rightBarButtonItem?.tintColor = #colorLiteral(red: 0.9712318778, green: 0.9606906772, blue: 0.6410447955, alpha: 1)
//           navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.init(red: 0.9712318778, green: 0.9606906772, blue: 0.6410447955, alpha: 1)]
//       }
//
//
//    @objc private func skipButton(){
//        present(OBNotifcationsVC(), animated: true, completion: nil)
//
//    }
    
    

}
