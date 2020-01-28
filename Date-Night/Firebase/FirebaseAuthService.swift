//
//  FirebaseAuthService.swift
//  Date-Night
//
//  Created by Michelle Cueva on 1/28/20.
//  Copyright © 2020 Michelle Cueva. All rights reserved.
//

import Foundation
import Firebase

class FirebaseAuthService {
    static let manager = FirebaseAuthService()
    
    private let auth = Auth.auth()

    var currentUser: User? {
        return auth.currentUser
    }
    
    
    
    func createNewUser(email: String, password: String, completion: @escaping (Result<User,Error>) -> ()) {
           auth.createUser(withEmail: email, password: password) { (result, error) in
               if let createdUser = result?.user {
                   completion(.success(createdUser))
               } else if let error = error {
                   completion(.failure(error))
               }
           }
       }
    
    func updateUserFields(userName: String? = nil,photoURL: URL? = nil, completion: @escaping (Result<(),Error>) -> ()){
          let changeRequest = auth.currentUser?.createProfileChangeRequest()
          if let userName = userName {
              changeRequest?.displayName = userName
          }
          if let photoURL = photoURL {
              changeRequest?.photoURL = photoURL
          }
          changeRequest?.commitChanges(completion: { (error) in
              if let error = error {
                  completion(.failure(error))
              } else {
                  completion(.success(()))
              }
          })
      }
    
    func loginUser(email: String, password: String, completion: @escaping (Result<(), Error>) -> ()) {
           auth.signIn(withEmail: email, password: password) { (result, error) in
            guard result?.user != nil else {
                if let error = error {
                completion(.failure(error))
                
            }
                return
            }
                completion(.success(()))
            
//            if let user = result?.user {
//                   completion(.success(()))
//               } else if let error = error {
//                   completion(.failure(error))
//               }
//           }
       }
        }
//    func signOut() {
//        do {
//             try Auth.auth().signOut()
//        } catch {
//            print(error)
//        }
//
    func signOut(completionHandler:@escaping(Result<(),AppError>)-> Void) {
          
        do {
               try Auth.auth().signOut()
            completionHandler(.success(()))
          } catch let error {
            completionHandler(.failure(.other(rawError: error)))
              
          }

    }
       private init () {}
    
    
}
