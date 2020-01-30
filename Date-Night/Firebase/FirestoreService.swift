

import Foundation
import FirebaseFirestore
import FirebaseAuth


enum FireStoreCollections: String {
    case users
    case posts
    case comments
    case favorites
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
    
    private let db = Firestore.firestore()
    
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
    private init () {}
}
