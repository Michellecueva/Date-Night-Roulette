

import Foundation
import FirebaseFirestore
import FirebaseAuth


enum FireStoreCollections: String {
    case users
    case posts
    case comments
    case invites
    
}

enum InviteField:String {
    case to
    case from
    case invitationStatus
}

enum SortingCriteria: String {
    case fromNewestToOldest = "dateCreated"
    var shouldSortDescending: Bool {
        switch self {
        case .fromNewestToOldest:
            return true
        }
    }
}


class FirestoreService {    
    static let manager = FirestoreService()
    
    public let db = Firestore.firestore()
    
    //MARK: AppUsers
    func createAppUser(user: AppUser, completion: @escaping (Result<(), Error>) -> ()) {
        var fields = user.fieldsDict
        fields["dateCreated"] = Date()
        db.collection(FireStoreCollections.users.rawValue).document(user.uid).setData(fields) { (error) in
            if let error = error {
                completion(.failure(error))
                print(error)
            }
            completion(.success(()))
        }
    }
    
    func updateCurrentUser(firstName: String? = nil, photoURL: URL? = nil, completion: @escaping (Result<(), Error>) -> ()){
        guard let userId = FirebaseAuthService.manager.currentUser?.uid else {
            //MARK: TODO - handle can't get current user
            return
        }
        var updateFields = [String:Any]()
        
        if let firstName = firstName {
            updateFields["firstName"] = firstName
        }
        
        
        if let photo = photoURL {
            updateFields["photoURL"] = photo.absoluteString
        }
        
        
        //PUT request
        db.collection(FireStoreCollections.users.rawValue).document(userId).updateData(updateFields) { (error) in
            if let error = error {
                completion(.failure(error))
            } else {
                completion(.success(()))
            }
            
        }
    }
    
    func updateCurrentUser(partnerEmail: String? = nil, completion: @escaping (Result<(), Error>) -> ()){
        guard let userId = FirebaseAuthService.manager.currentUser?.uid else {
            //MARK: TODO - handle can't get current user
            return
        }
        var updateFields = [String:Any]()
        
        if let partnerEmail = partnerEmail {
            updateFields["partnerEmail"] = partnerEmail
        }
        
        //PUT request
        db.collection(FireStoreCollections.users.rawValue).document(userId).updateData(updateFields) { (error) in
            if let error = error {
                completion(.failure(error))
            } else {
                completion(.success(()))
            }
        }
    }
    
    func updateCurrentUser(partnerUserName: String? = nil, completion: @escaping (Result<(), Error>) -> ()){
        guard let userId = FirebaseAuthService.manager.currentUser?.uid else {
            //MARK: TODO - handle can't get current user
            return
        }
        var updateFields = [String:Any]()
        
        if let partnerUserName = partnerUserName {
            updateFields["partnerUserName"] = partnerUserName
        }
        
        //PUT request
        db.collection(FireStoreCollections.users.rawValue).document(userId).updateData(updateFields) { (error) in
            if let error = error {
                completion(.failure(error))
            } else {
                completion(.success(()))
            }
        }
    }
    
    
    func getAllUsers(completion: @escaping (Result<[AppUser], Error>) -> ()) {
        db.collection(FireStoreCollections.users.rawValue).getDocuments { (snapshot, error) in
            if let error = error {
                completion(.failure(error))
            } else {
                let users = snapshot?.documents.compactMap({ (snapshot) -> AppUser? in
                    let userID = snapshot.documentID
                    let user = AppUser(from: snapshot.data(), id: userID)
                    return user
                })
                completion(.success(users ?? []))
            }
        }
    }
    
    func deleteAllDocuments(docIDs:[String],path:FireStoreCollections,completionHandler:@escaping(Result<(),AppError>) -> ()) {
        
        for docID in docIDs {
            db.collection(path.rawValue).document(docID).delete { (error) in
                if let error = error {
                    completionHandler(.failure(.other(rawError: error)))
                } else {
                    completionHandler(.success(()))
                }
            }
        }
    }
    
    
    func getUser(userID: String, completion: @escaping (Result<AppUser, Error>) -> ()) {
        db.collection(FireStoreCollections.users.rawValue).document(userID).getDocument { (snapshot, error) in
            if let error = error {
                completion(.failure(error))
            } else {
                let userdata = snapshot?.data()
                let user = AppUser(from: userdata!, id: userID)
                completion(.success(user!))
            }
        }
    }
    
    func getPartnersUserData(partnerEmailAddress: String, completionHandler: @escaping (Result<[AppUser], Error>) -> ()) {
        db.collection(FireStoreCollections.users.rawValue).whereField("email", isEqualTo: partnerEmailAddress.lowercased()).getDocuments { (snapshot, error) in
            if let error = error {
                completionHandler(.failure(error))
            } else {
                let userData = snapshot?.documents.compactMap({ (snapshot) -> AppUser? in
                    
                    let userID = snapshot.documentID
                    let data = snapshot.data()
                    return AppUser(from: data, id: userID)
                })
                completionHandler(.success(userData ?? []))
            }
        }
    }
    
    
    
    func sendInvite(invite:Invites,completionHandler:@escaping (Result<(),AppError>)-> ()) {
        let inviteField = invite.fieldsDictionary
        db.collection(FireStoreCollections.invites.rawValue).addDocument(data: inviteField) { (error) in
            if let error = error {
                completionHandler(.failure(.other(rawError: error)))
            } else {
                completionHandler(.success(()))
            }
        }
        //add snapshot listener
    }
    
    //  messageListener = reference?.addSnapshotListener { querySnapshot, error in
    //    guard let snapshot = querySnapshot else {
    //      print("Error listening for channel updates: \(error?.localizedDescription ?? "No error")")
    //      return
    //    }
    //
    //    snapshot.documentChanges.forEach { change in
    //      self.handleDocumentChange(change)
    //    }
    //  }
    //
    
    // MARK: Invitation Functionality
    
    
    func getAllInvites(userEmailAddress:String,completionHandler:@escaping (Result<[Invites],AppError>)-> ()) {
        
        
        db.collection(FireStoreCollections.invites.rawValue).whereField("to", isEqualTo: userEmailAddress.lowercased()).getDocuments { (snapshot, error) in
            if let error = error {
                completionHandler(.failure(.other(rawError: error)))
            } else {
                let inviteData = snapshot?.documents.compactMap({ (snapshot) -> Invites? in
                    
                    let inviteID = snapshot.documentID
                    let data = snapshot.data()
                    return Invites(from: data, id: inviteID)
                })
                completionHandler(.success(inviteData ?? []))
            }
        }
    }
    
    
    func removeInvite(invite:Invites, completion: @escaping (Result<(), Error>) -> ()) {
        db.collection(FireStoreCollections.invites.rawValue).document(invite.id).delete() { err in
            if let err = err {
                completion(.failure(err))
            } else {
                completion(.success(()))
            }
        }
    }
    
    func updateInvitationStatus(inviteID: String, invitationStatus: String, completion: @escaping (Result<(), Error>) -> ()) {
        var updateFields = [String:Any]()
        updateFields["invitationStatus"] = invitationStatus
        db.collection(FireStoreCollections.invites.rawValue).document(inviteID).updateData(updateFields) {
            (error) in
            if let error = error {
                completion(.failure(error))
            } else {
                completion(.success(()))
            }
        }
    }
    
    private init () {}
}
