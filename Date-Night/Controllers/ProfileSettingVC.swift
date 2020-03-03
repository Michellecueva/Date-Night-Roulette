//
//  ProfileVC.swift
//  Date-Night
//
//  Created by Phoenix McKnight on 2/10/20.
//  Copyright © 2020 Michelle Cueva. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseFirestore
import Photos


class ProfileSettingVC: UIViewController {
    
    var profileSetting = ProfileSettingView()
    
    var isCurrentUser = false
    
    var image = UIImage(){
        didSet {
            self.profileSetting.portraitPic.image = image
        }
    }
    
    var imageURL: URL? = nil
    
    var currentUser:AppUser? = nil {
        didSet {
            profileSetting.partnerEmailDisplayLabel.text = currentUser?.partnerEmail
            profileSetting.userNameLabel.text = "Hi, \(currentUser?.userName ?? "")"
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        view.addSubview(profileSetting)
        addObjcFunction()
        //    profileSetting.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        logOut()
        print(FirebaseAuthService.manager.currentUser?.email)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setUpProfilePortrait()
    }
    
    private func setUpUserName() {
        if let userName = FirebaseAuthService.manager.currentUser?.displayName {
            profileSetting.userNameLabel.text = "Hi \(userName) !"
            
        }
    }
    
    private func setUpPartnerEmailDisplay(userID: String){
        FirestoreService.manager.getUser(userID: userID) { (result) in
            switch result {
            case .success(let user):
                self.profileSetting.partnerEmailDisplayLabel.text = user.partnerEmail
                print("succesfully added partner email\(user.partnerEmail)")
            case .failure(let error):
                print(error)
            }
        }
    }
    
    private func presentPhotoPickerController(){
        DispatchQueue.main.async {
            let imagePickerViewController = UIImagePickerController()
            imagePickerViewController.delegate = self
            imagePickerViewController.sourceType = .photoLibrary
            imagePickerViewController.allowsEditing = true
            imagePickerViewController.mediaTypes = ["public.image"]
            self.present(imagePickerViewController, animated: true, completion: nil)
        }
    }
    
    private func showAlert(with title: String, and message: String){
        let alertVC = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertVC.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        present(alertVC, animated: true, completion: nil)
    }
    
    private func addObjcFunction() {
        profileSetting.addPictureButton.addTarget(self, action: #selector(addProfileImage), for: .touchUpInside)
        
    }
    
    @objc private func addProfileImage() {
        switch PHPhotoLibrary.authorizationStatus(){
        case .notDetermined, .denied, .restricted:
            PHPhotoLibrary.requestAuthorization({[weak self] status in
                switch status {
                case .authorized:
                    self?.presentPhotoPickerController()
                case .denied:
                    print("Denied photo library permissions")
                default:
                    print("no status")
                    
                    
                }
            })
        default: presentPhotoPickerController()
        }
        
    }
    
    private func logOut(){
        profileSetting.logoutButton.addTarget(self, action: #selector(signOut), for:.touchUpInside )
    }
    
    @objc private func signOut(){
        FirebaseAuthService.manager.signOut { [weak self](result) in
            self?.handleSignOut(vc: SignInVC(), with: result)
        }
        
    }
    private func handleSignOut(vc
        viewController:UIViewController,with result: Result<(), AppError>) {
        switch result {
            
        case .success:
            guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
                let sceneDelegate = windowScene.delegate as? SceneDelegate, let window = sceneDelegate.window
                else {
                    return
            }
            
            UIView.transition(with: window, duration: 0.3, options: .transitionFlipFromBottom, animations: {
                if FirebaseAuthService.manager.currentUser == nil {
                    window.rootViewController = viewController
                    
                } else {
                    
                    print("No current user")
                }
            }, completion: nil)
        case .failure(let error):
            print(error)
        }
    }
    
    private func setUpProfilePortrait() {
        guard let photoURL = Auth.auth().currentUser?.photoURL?.absoluteString else {return}
        ImageHelper.shared.getImage(urlStr: photoURL) { [weak self](result) in
            DispatchQueue.main.async {
                switch result {
                    
                case .failure(let error):
                    print(error)
                    
                case .success(let image):
                    self?.profileSetting.portraitPic.image = image
                }
            }
        }
    }
    
    private func handleUpdateCurentUser(result:Result<(),Error>,url:URL) {
        switch result {
        case .failure(let error):
            print(error)
        case .success():
            
            FirestoreService.manager.updateCurrentUser(photoURL: url) { (result) in
                switch result {
                case .failure(let error):
                    print(error)
                case .success():
                    print("saved profile change in appuser")
                }
            }
        }
    }
    
}

extension ProfileSettingVC: UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let image = info[.editedImage] as? UIImage else {
            return
        }
        self.image = image
        guard let imageData = image.jpegData(compressionQuality: 0.6) else {
            return
        }
        FirebaseStorageService.manager.storeImage(image: imageData) { (result) in
            switch result {
            case .failure(let error):
                print(error)
                
            case .success(let url):
                FirebaseAuthService.manager.updateUserFields( photoURL: url) { (result) in
                    switch result {
                    case .failure(let error):
                        print(error)
                    case .success():
                        print("updated photo url in auth user")
                        self.handleUpdateCurentUser(result: result, url: url)
                    }
                }
            }
        }
        
        dismiss(animated: true, completion: nil)
    }
}





