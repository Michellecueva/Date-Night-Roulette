

import Foundation
import FirebaseFirestore
import FirebaseAuth


enum FireStoreCollections: String {
    case users
    case posts
    case comments
    case invites
    case MatchedEvents
    
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
    
    func updateCurrentUser(userName: String? = nil, photoURL: URL? = nil, completion: @escaping (Result<(), Error>) -> ()){
        guard let userId = FirebaseAuthService.manager.currentUser?.uid else {
            //MARK: TODO - handle can't get current user
            return
        }
        var updateFields = [String:Any]()
        
        if let userName = userName {
            updateFields["userName"] = userName
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
    
    func updateCurrentUser(partnerUserName: String?, coupleID: String?, completion: @escaping (Result<(), Error>) -> ()){
        guard let userId = FirebaseAuthService.manager.currentUser?.uid else {
            //MARK: TODO - handle can't get current user
            return
        }
        var updateFields = [String:Any]()
        
        if let partnerUserName = partnerUserName {
            updateFields["partnerUserName"] = partnerUserName
        }
        
        if let coupleID = coupleID {
                   updateFields["coupleID"] = coupleID
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
    
    func updatePartnerUser(partnerUID: String, coupleID: String, completion: @escaping (Result<(), Error>) -> ()){
        let currentUserEmail = FirebaseAuthService.manager.currentUser?.email
        let currentUserName = FirebaseAuthService.manager.currentUser?.displayName
        var updateFields = [String:Any]()
        
        updateFields["partnerEmail"] = currentUserEmail
        updateFields["partnerUserName"] = currentUserName
        updateFields["coupleID"] = coupleID

        
     
        //PUT request
        db.collection(FireStoreCollections.users.rawValue).document(partnerUID).updateData(updateFields) { (error) in
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
    
    func deleteAllDocuments(docIDs:[String],
                            path:FireStoreCollections,
                            completionHandler:@escaping(Result<(),AppError>) -> ())
    {

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
    
    func getPartnersUserData(partnerEmailAddress: String,completionHandler: @escaping (Result<[AppUser], Error>) -> ()) {
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
    
    func savePreferencesForUser(
        field:FireStoreCollections,
        preferences:[String],
        currentUserUID:String,
        completionHandler:@escaping(Result<(),AppError>) -> ())
    {
       
        var updateFields = [String:Any]()
               updateFields["preferences"] = preferences
        db.collection(FireStoreCollections.users.rawValue).document(currentUserUID).updateData(updateFields) { (error) in
            if let error = error {
                completionHandler(.failure(.other(rawError: error)))
            } else {
                completionHandler(.success(()))
            }
        }
    }
    
    func sendEventsToFirebase(event:FBEvents,completionHandler:@escaping (Result<(),AppError>) ->()) {
        
            let eventField = event.fieldsDict
            db.collection("FBEvents").addDocument(data: eventField) { (error) in
                if let error = error {
                    completionHandler(.failure(.other(rawError: error)))
                } else {
                    completionHandler(.success(()))
                }
            }
    }
    
    func getEventsFromFireBase(preference: String,completion: @escaping (Result<[FBEvents], Error>) -> ()) {
        db.collection("FBEvents").whereField("type", isEqualTo: preference).getDocuments { (snapshot, error) in
                if let error = error {
                    completion(.failure(error))
                } else {
                    let eventData = snapshot?.documents.compactMap({ (snapshot) -> FBEvents? in
                            
                            let eventID = snapshot.documentID
                            let data = snapshot.data()
                            return FBEvents(from: data, id: eventID)
                        })
                        completion(.success(eventData ?? []))
                    }
        }

    }
    
    
    
    // MARK: Invitation Functionality
    
    func sendInvite(invite:Invites,completionHandler:@escaping (Result<(),AppError>)-> ()) {
        let inviteField = invite.fieldsDictionary
        db.collection(FireStoreCollections.invites.rawValue).addDocument(data: inviteField) { (error) in
            if let error = error {
                completionHandler(.failure(.other(rawError: error)))
            } else {
                completionHandler(.success(()))
            }
        }

    }
    
    func getAllInvites(
        inviteField:InviteField,
        userEmailAddress:String,
        completionHandler:@escaping (Result<[Invites],AppError>) -> ())
    {
        
        db.collection(FireStoreCollections.invites.rawValue).whereField(inviteField.rawValue, isEqualTo: userEmailAddress.lowercased()).getDocuments { (snapshot, error) in
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
    
    func updateInvitationStatus(inviteID: String,
                                invitationStatus: String,
                                completion: @escaping (Result<(), Error>) -> ())
    {
        var updateFields = [String:Any]()
        updateFields[InviteField.invitationStatus.rawValue] = invitationStatus
        db.collection(FireStoreCollections.invites.rawValue).document(inviteID).updateData(updateFields) {
            (error) in
            if let error = error {
                completion(.failure(error))
            } else {
                completion(.success(()))
            }
        }
    }
    
    // MARK: Events Functionality
    
    
    func updateEventsLiked(eventsLiked: [String], completion: @escaping (Result<(), Error>) -> () ) {
        guard let userId = FirebaseAuthService.manager.currentUser?.uid else {
            return
        }
        
        var updateFields = [String:Any]()
        
        updateFields["eventsLiked"] = eventsLiked
        
        db.collection(FireStoreCollections.users.rawValue).document(userId).updateData(updateFields) {
            (error) in
            if let error = error {
                completion(.failure(error))
            } else {
                completion(.success(()))
            }
        }
    }
    
    func createMatchedEvent(matchedEvent: MatchedEvent, completionHandler: @escaping (Result<(), AppError>) -> ()) {
        
        let eventsMatchedField = matchedEvent.fieldsDict
        db.collection(FireStoreCollections.MatchedEvents.rawValue).addDocument(data: eventsMatchedField) { (error) in
            if let error = error {
                completionHandler(.failure(.other(rawError: error)))
            } else {
                completionHandler(.success(()))
            }
        }
    }
    
    func getMatchedHistory(userID: String, partnerID: String, completionHandler: @escaping (Result <[MatchedEvent], Error>) -> () ) {
        db.collection(FireStoreCollections.MatchedEvents.rawValue).whereField("userOne", isEqualTo: userID)
            .whereField("userTwo", isEqualTo: partnerID).getDocuments { (snapshot, error) in
                if let error = error {
                    completionHandler(.failure(error))
                } else {
                    let matchedData = snapshot?.documents.compactMap({ (snapshot) -> MatchedEvent? in
                        let matchedID = snapshot.documentID
                        let data = snapshot.data()
                        return MatchedEvent(from: data, id: matchedID)
                    })
                    
                    completionHandler(.success(matchedData ?? []))
                }
        }
        
    }
    
//    func getEventsFromFireBase(preference: String,completion: @escaping (Result<[FBEvents], Error>) -> ()) {
//        db.collection("FBEvents").whereField("type", isEqualTo: preference).getDocuments { (snapshot, error) in
//                if let error = error {
//                    completion(.failure(error))
//                } else {
//                    let eventData = snapshot?.documents.compactMap({ (snapshot) -> FBEvents? in
//
//                            let eventID = snapshot.documentID
//                            let data = snapshot.data()
//                            return FBEvents(from: data, id: eventID)
//                        })
//                        completion(.success(eventData ?? []))
//                    }
//        }
//    }
    
    private init () {}
}
