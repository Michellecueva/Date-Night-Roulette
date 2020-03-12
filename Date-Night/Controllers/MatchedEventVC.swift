import UIKit

class MatchedEventVC: UIViewController {
    
    var matchedView = MatchedEventView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(matchedView)
        addObjcFunctions()

        // Do any additional setup after loading the view.
    }
    

    private func addObjcFunctions() {
        matchedView.directionButton.addTarget(self, action: #selector(directionsLink), for: .touchUpInside)
        matchedView.moreInfoButton.addTarget(self, action: #selector(infoLink), for: .touchUpInside)
    }

    
    @objc private func directionsLink() {}
    @objc private func infoLink() {}
}
