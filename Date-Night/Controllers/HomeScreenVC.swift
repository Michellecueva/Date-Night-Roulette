//
//  HomeScreenVC.swift
//  Date-Night
//
//  Created by Phoenix McKnight on 1/31/20.
//  Copyright © 2020 Michelle Cueva. All rights reserved.
//

import UIKit
import FirebaseFirestore
import FirebaseAuth

class HomeScreenVC: UIViewController {
    
    private var inviteListener: ListenerRegistration?
    private let db = Firestore.firestore()
    
    private var currentUserEmail:String {
        if let user = Auth.auth().currentUser?.email {
            return user
        } else {
            return "Invalid Email"
        }
    }
    
    private var collectionReference:CollectionReference {
        return db.collection("invites")
    }
    
    deinit {
        inviteListener?.remove()
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("Current User: \(currentUserEmail)")
        addListener()
        sendInvite()
    }
    
    private func addListener() {
        inviteListener = collectionReference.addSnapshotListener({ (snapshot, error) in
            
            if let error = error {
                print(error.localizedDescription)
            }
            guard let snapshot = snapshot else {
                //add alert
                
                return}
            snapshot.documentChanges.forEach {
                (change) in
                self.handleInvitation(change: change)
                print("Invites in Firebase: \(change.document.data())")
            }
            
        })
    }
    private func sendInvite() {
        let invite = Invites(from: currentUserEmail, to: "testEmail@gmail.com", invitationStatus: .pending)
        
        FirestoreService.manager.sendInvite(invite: invite) { (result) in
            switch result {
            case .failure(let error):
                print(error)
                
            case .success():
                print("Invite was succesfully sent")
            }
        }
    }
    
    private func handleInvitation(change:DocumentChange) {
        switch change.type {
        case .added:
            FirestoreService.manager.getAllInvites(userEmailAddress: currentUserEmail) { (result) in
                switch result {
                case .failure(let error):
                    print(error)
                case .success(let inviteList):
                    print("Added new invite. Invites where user has a pending invite. \(inviteList.count)")
                }
            }
        case .modified:
            print("Database was modified")
        case .removed:
            print("Invitation removed from database")
        }
    }
}
