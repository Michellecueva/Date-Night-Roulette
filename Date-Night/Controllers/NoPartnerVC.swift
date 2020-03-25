//
//  NoPartnerVC.swift
//  Date-Night
//
//  Created by Krystal Campbell on 3/25/20.
//  Copyright © 2020 Date Night Roulette. All rights reserved.
//

import UIKit

class NoPartnerVC: UIViewController {
 
    let noPartner = NoPartnerView()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(noPartner)
        addObjcFunctions()
        
    }
    
    private func addObjcFunctions() {
        noPartner.sendInviteButton.addTarget(self, action: #selector(inviteButton ), for: .touchUpInside)
      }
      
      
      @objc private func inviteButton(){
          present(OBSendInviteVC(), animated: true, completion: nil)
         
      }
   
}
