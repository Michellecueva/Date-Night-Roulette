//
//  WaitingForResponseVC.swift
//  Date-Night
//
//  Created by Kimball Yang on 2/10/20.
//  Copyright © 2020 Michelle Cueva. All rights reserved.
//

import UIKit
import FirebaseAuth

class WaitingForResponseVC: UIViewController {
    
var waitingResponse = WaitingForResponseView()

    var delegate:WaitingForResponseDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(waitingResponse)
        addTargetToUnsendInviteButton()
        
    }
    
    private func addTargetToUnsendInviteButton() {
        waitingResponse.unsendButton.addTarget(self, action: #selector(unSendInvite), for: .touchUpInside)
    }
    
    @objc private func unSendInvite() {
        guard let email = Auth.auth().currentUser?.email else {return}
        
        FirestoreService.manager.removeInvitesFromUser(userEmail: email) { (result) in
            switch result {
            case .failure(let error):
                print(error)
            case .success():
                print("removed invite")
                self.delegateFunction()
                
            }
        }
    }
    private func delegateFunction() {
        delegate?.changeStatusWaiting(status: .sendInvite)
    }
}
