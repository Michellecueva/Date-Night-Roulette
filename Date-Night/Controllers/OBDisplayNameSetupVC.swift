//
//  OBDisplayNameSetupVC.swift
//  Date-Night
//
//  Created by Krystal Campbell on 3/20/20.
//  Copyright © 2020 Date Night Roulette. All rights reserved.
//

import UIKit
import FirebaseAuth

class OBDisplayNameSetupVC: UIViewController {

    
     let obDisplayName = OBDisplayNameSetupView()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(obDisplayName)
        addObjcFunctions()
      
    }
    


    private func addObjcFunctions() {
        obDisplayName.nextButton.addTarget(self, action: #selector(addDisplayName), for: .touchUpInside)
        
       }
       
       
       @objc private func addDisplayName(){
        
             //  present(OBDisplayNameSetupVC(), animated: true, completion: nil)
       }
       
    

}
