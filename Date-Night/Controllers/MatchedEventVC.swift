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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        guard let newImage = newImage else {
            return
        }
        matchedView.addImage(image: newImage)
    }
    

    private func addObjcFunctions() {
        matchedView.directionButton.addTarget(self, action: #selector(directionsLink), for: .touchUpInside)
        matchedView.moreInfoButton.addTarget(self, action: #selector(infoLink), for: .touchUpInside)
    }

    
    @objc private func directionsLink() {}
    @objc private func infoLink() {}
}
