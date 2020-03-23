import UIKit

class MatchedEventVC: UIViewController {
    
    var matchedView = MatchedEventView()
    
    var newImage:UIImage? 
    
    var event: FBEvents!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(matchedView)
        addObjcFunctions()
        addImage()
    }
    
    private func addImage() {
        if newImage != nil {
             matchedView.matchImage.image = newImage
        } else {
            // get info from MatchedEvent
            print("noImageAvailable")
        }
    }
    

    private func addObjcFunctions() {
        matchedView.directionButton.addTarget(self, action: #selector(directionsLink), for: .touchUpInside)
        matchedView.moreInfoButton.addTarget(self, action: #selector(infoLink), for: .touchUpInside)
    }

    
    @objc private func directionsLink() {
        guard let direction = event.address else {return}
        let urlLink = "https://www.google.com/maps/place/\(direction.replacingOccurrences(of: " ", with: "+"))"
//        let array = ["133 Mulberry St","New York, NY 10013"]
//        let sent = array.joined(separator: " ").replacingOccurrences(of: " ", with: "+")
//       print(sent)
//        let url = "https://www.google.com/maps/place/\(sent)"
        
        print(urlLink)
        
        guard let urlStr = URL(string: urlLink) else {return}
        UIApplication.shared.open(urlStr, options: [:], completionHandler: nil)
        
    }
    @objc private func infoLink() {
        guard let url = event.websiteURL else {return}
        guard let urlStr = URL(string: url) else {return}
        
        UIApplication.shared.open(urlStr, options: [:], completionHandler: nil)
    }
}
