//
//  SplashScreenVC.swift
//  Date-Night
//
//  Created by Kimball Yang on 2/14/20.
//  Copyright © 2020 Michelle Cueva. All rights reserved.
//

import UIKit

class SplashScreenVC: UIViewController {

    var splashScreen = SplashScreenView()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(splashScreen)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        rotateAndDismiss()
    

    }
    private func rotateAndDismiss() {
        guard let windowscene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
            let scenedelegate = windowscene.delegate as? SceneDelegate, let window = scenedelegate.window
            else {
                
            return
        }
        
        
        UIView.animate(withDuration: 2.0, animations: {
            self.splashScreen.splashLogo.transform = CGAffineTransform(rotationAngle: CGFloat.pi)
        }) { (_) in
            
            UIView.transition(with: window, duration: 0.8, options: .curveEaseInOut, animations: {
                window.rootViewController = SignInVC()
            }, completion: nil)
        }
    }
    
    
    private func rotateSplashLogo() {
    UIView.animate(withDuration: 2.0, animations: {
        self.splashScreen.splashLogo.transform = CGAffineTransform(rotationAngle: CGFloat.pi)
            }
        )

    }
    
//    private func finishRotate() {
//        UIView.animate(withDuration 1.0, animations: {
//            self.splashScreen.splashLogo.transform =
//            CGAffineTransform(rotationAngle: CGFloat.pi * 2)
//        })
//    }
    
    
    
    // (180.0 * .pi) / 180.0)

}
