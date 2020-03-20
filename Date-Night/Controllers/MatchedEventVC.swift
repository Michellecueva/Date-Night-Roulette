import UIKit

class MatchedEventVC: UIViewController {
    
    var matchedView = MatchedEventView()
    
    var newImage:UIImage? 
    
    var event: FBEvents!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(matchedView)
        addObjcFunctions()
        guard let newImage = newImage else {
                   return
               }
               matchedView.matchImage.image = newImage

        // Do any additional setup after loading the view.
    }
    

    private func addObjcFunctions() {
        matchedView.directionButton.addTarget(self, action: #selector(directionsLink), for: .touchUpInside)
        matchedView.moreInfoButton.addTarget(self, action: #selector(infoLink), for: .touchUpInside)
    }

    
    @objc private func directionsLink() {
    }
    @objc private func infoLink() {
        guard let url = event.websiteURL else {return}
        guard let urlStr = URL(string: url) else {return}
        
        UIApplication.shared.open(urlStr, options: [:], completionHandler: nil)
    }
}
