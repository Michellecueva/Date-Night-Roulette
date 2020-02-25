//
//  DiscoverEventVC.swift
//  Date-Night
//
//  Created by Kimball Yang on 2/6/20.
//  Copyright © 2020 Michelle Cueva. All rights reserved.
//

import UIKit

class DiscoverEventVC: UIViewController {

    var discover = DiscoverEventView()
    
    //add button 
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        view.addSubview(discover)
        addObjcFunctions()
    }

    
    private func addObjcFunctions() {
        discover.myPreferencesButton.addTarget(self, action: #selector(goToPreferences), for: .touchUpInside)
        discover.randomEventButton.addTarget(self, action: #selector(goToRandomEvent), for: .touchUpInside)
        discover.discoverEventButton.addTarget(self, action: #selector(goToDiscoverEvent), for: .touchUpInside)
       }
       
     @objc private func goToPreferences() {

        present(PreferenceVC(), animated: true, completion: nil)
    }
    
    @objc private func goToRandomEvent() {

        present(RandomEventVC(), animated: true, completion: nil)
    }
    
    @objc private func goToDiscoverEvent() {

       // present(PreferenceVC(), animated: true, completion: nil)
    }
    
}
