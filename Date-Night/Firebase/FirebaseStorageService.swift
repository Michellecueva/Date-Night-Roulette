//
//  FirebaseStorageService.swift
//  PursuitsGram
//
//  Created by Krystal Campbell on 11/25/19.
//  Copyright © 2019 Krystal Campbell. All rights reserved.
//

import Foundation
import FirebaseStorage

class FirebaseStorageService {
    
    //consider using two managers
    // static var profileManager = FirebaseStorageService(type: .profile)
    // static var uploadManager = FirebaseStorageService(type: .upload)
    static var manager = FirebaseStorageService()
    
    private let storage: Storage!
    private let storageReference: StorageReference
    private let imagesFolderReference: StorageReference
    
    private init() {
        storage = Storage.storage()
        storageReference = storage.reference()
        imagesFolderReference = storageReference.child("images")
    }
    
    func storeImage(image: Data,  completion: @escaping (Result<URL,Error>) -> ()) {
        let metadata = StorageMetadata()
        metadata.contentType = "image/jpeg"
        let uuid = UUID()
        let imageLocation = imagesFolderReference.child(uuid.description)
        imageLocation.putData(image, metadata: metadata) { (responseMetadata, error) in
            if let error = error {
                completion(.failure(error))
            } else {
                //Try to get the actual URL for our image
                imageLocation.downloadURL { (url, error) in
                    guard error == nil else {completion(.failure(error!));return}
                    //MARK: TODO - set up custom app errors
                    guard let url = url else {completion(.failure(error!));return}
                    completion(.success(url))
                }
            }
        }
    }
    
    func getImage(url: String, completion: @escaping (Result<UIImage, Error>)-> ()){
        imagesFolderReference.storage.reference(forURL: url).getData(maxSize: 2000000) { (data, error) in
            if let error = error {
                completion(.failure(error))
            } else if let data = data, let image = UIImage(data: data){
                completion(.success(image))
            }
        }
    }
    func getUserImage(photoURL: URL, completion: @escaping (Result<UIImage, Error>)->()){
        imagesFolderReference.storage.reference(forURL: photoURL.absoluteString).getData(maxSize: 2000000) { (data, error) in
            if let error = error {
                completion(.failure(error))
            } else if let data = data, let image = UIImage(data: data){
                completion(.success(image))
            }
        }
    }
}
