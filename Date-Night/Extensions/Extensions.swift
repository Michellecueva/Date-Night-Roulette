
import UIKit

extension CALayer{
    func setCustomLayer(radius:CGFloat){
        cornerRadius = radius
        borderWidth = 2
        borderColor = UIColor.black.cgColor
        masksToBounds = true
        shadowColor = UIColor.black.cgColor
        shadowOffset = CGSize(width: 0, height: 5.0)
        shadowRadius = 20.0
        shadowOpacity = 0.5
        masksToBounds = false
    }
}

//extension UIImageView {

//    func getImage(with urlString: String, completion: @escaping (Result<UIImage, AppError>) -> ()) {
//        let activityIndicator = UIActivityIndicatorView(style: .large)
//        activityIndicator.color = .orange
//        activityIndicator.startAnimating()
//        activityIndicator.hidesWhenStopped = true
//        activityIndicator.center = center
//        addSubview(activityIndicator)
//        
//        guard let url = URL(string: urlString) else {
//            completion(.failure(.badURL))
//            return
//        }
//        
//        let request = URLRequest(url: url)
//        
//        NetworkHelper.manager.performDataTask(withUrl: url, andMethod: .get) { [weak self] (result) in
//            DispatchQueue.main.async {
//                
//            
//            switch result {
//            case .failure(let appError):
//               activityIndicator.stopAnimating()
//               completion(.failure(.notAnImage))
//            case .success(let data):
//                activityIndicator.stopAnimating()
//                
//                if let image = UIImage(data: data) {
//                    completion(.success(image))
//                }
//            }
//        }
//    }
//}
//}

extension UIView {
    func setGradientBackground(colorTop: UIColor, colorBottom: UIColor) {
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [colorBottom.cgColor, colorTop.cgColor]
        gradientLayer.startPoint = CGPoint(x: 0.5, y: 1.0)
        gradientLayer.endPoint = CGPoint(x: 0.5, y: 0.0)
        gradientLayer.locations = [0, 1]
        gradientLayer.frame = self.bounds
        
        self.layer.insertSublayer(gradientLayer, at: 0)
        
    }
}

extension UILabel {
    public convenience init(font:UIFont){
        self.init()
        self.textAlignment = .center
        self.textColor = .black
        self.adjustsFontSizeToFitWidth = true
        self.numberOfLines = 0
        self.font = font
    }
}

extension UICollectionViewFlowLayout {
    public convenience init(placeHolder:String) {
        self.init()
        self.scrollDirection = .horizontal
        self.itemSize = CGSize(width: 150, height:150)
        self.minimumInteritemSpacing = 20
        self.minimumLineSpacing = 20
        self.sectionInset = UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20)
    }
}

extension UIViewController {
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    public func showAlert(title: String, message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Ok", style: .default) { alert in }
        alertController.addAction(okAction)
        present(alertController, animated: true, completion: nil)
    }
}

extension Date {
    // get an ISO timestamp
    static func getISOTimestamp() -> String {
        let isoDateFormatter = ISO8601DateFormatter()
        let timestamp = isoDateFormatter.string(from: Date())
        return timestamp
    }
}

extension String {
    // create a formatted date from ISO
    // e.g "MMM d, yyyy hh:mm a"
    // e.g usage addedAt.formattedDate("MMM d, yyyy")
    public func formatISODateString(dateFormat: String) -> String {
        var formatDate = self
        let isoDateFormatter = ISO8601DateFormatter()
        if let date = isoDateFormatter.date(from: self) {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = dateFormat
            formatDate = dateFormatter.string(from: date)
        }
        return formatDate
    }
    
    static func isEmailValid(_ email : String) -> Bool {
        let emailTest = NSPredicate(format: "SELF MATCHES %@", "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}")
        return emailTest.evaluate(with: email)
    }
    
    static func isPasswordValid(_ password : String) -> Bool {
        let passwordTest = NSPredicate(format: "SELF MATCHES %@", "^(?=.*[a-z])(?=.*[$@$#!%*?&])[A-Za-z\\d$@$#!%*?&]{8,}")
        return passwordTest.evaluate(with: password)
    }
}
