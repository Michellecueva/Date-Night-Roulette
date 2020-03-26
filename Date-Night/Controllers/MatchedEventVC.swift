import UIKit

class MatchedEventVC: UIViewController {
    
    var matchedView = MatchedEventView()
    
    var event: EventsShown!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = StyleGuide.AppColors.backgroundColor
        view.addSubview(matchedView)
        addObjcFunctions()
        addImage()
    }
    
    private func addImage() {
        guard let image = event.imageUrl else {return}
        ImageHelper.shared.getImage(urlStr: image) { [weak self](result) in
            DispatchQueue.main.async {
                switch result {
                case .failure(let error):
                    print("failed to get image \(error)")
                    self?.matchedView.matchImage.image = UIImage(systemName: "photo")
                case .success(let imageFromOnline):
                    self?.matchedView.matchImage.image = imageFromOnline
                }
            }
        }
    }
    
    private func addObjcFunctions() {
        matchedView.directionButton.addTarget(self, action: #selector(directionsLink), for: .touchUpInside)
        matchedView.moreInfoButton.addTarget(self, action: #selector(infoLink), for: .touchUpInside)
    }
    
    @objc private func directionsLink() {
        guard let direction = event.location else {return}
        let urlLink = "https://www.google.com/maps/place/\(direction.replacingOccurrences(of: " ", with: "+"))"
        
        guard let urlStr = URL(string: urlLink) else {return}
        UIApplication.shared.open(urlStr, options: [:], completionHandler: nil)
    }
    
    @objc private func infoLink() {
        guard let url = event.websiteUrl else {return}
        guard let urlStr = URL(string: url) else {return}
        
        UIApplication.shared.open(urlStr, options: [:], completionHandler: nil)
    }
}
