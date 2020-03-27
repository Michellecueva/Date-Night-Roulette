
import UIKit
import UserNotifications

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

extension UNNotification {
    static func configureNotifications(title: String, body: String, time: Double,categoryIdentifier:String){
        let center = UNUserNotificationCenter.current()
        let content = UNMutableNotificationContent()
        
        
        content.title = NSString.localizedUserNotificationString(forKey: title, arguments: nil)
        content.body = NSString.localizedUserNotificationString(forKey: body, arguments: nil)
        content.sound = .defaultCritical
        
        content.categoryIdentifier = categoryIdentifier
        
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: time, repeats: false)
        let request = UNNotificationRequest(identifier: title, content: content, trigger: trigger)
        center.add(request) { error in
            if let error = error{
                print(error)
            } else {
                print("added notification for \(time) seconds from now")
            }
        }
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
        public func beginAnimation() {
            UIView.animate(withDuration: 0.5, delay: 0, options: .curveLinear, animations: { () -> Void in
                     self.transform = self.transform.rotated(by: .pi / 2)
                 }) { (finished) -> Void in
                     self.beginAnimation()
                    }
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
    
    func makeNavBarOpaque() {
        self.navigationController?.navigationBar.setBackgroundImage(nil, for: .default)
    }
    
    func makeNavBarTranslucent() {
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.view.backgroundColor = .clear
        self.navigationController?.navigationBar.backgroundColor = .clear
    }
    
    func add(_ child: UIViewController) {
        addChild(child)
        view.addSubview(child.view)
        child.didMove(toParent: self)
    }
    
    func remove() {
        // Just to be safe, we check that this view controller
        // is actually added to a parent before removing it.
        guard parent != nil else {
            return
        }
        
        willMove(toParent: nil)
        view.removeFromSuperview()
        removeFromParent()
    }
    
    
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
    
    public func testAlert(controllerTitle:String?, controllerMessage:String?,actionOneTitle:String?, actionTwoTitle:String?,actionOneClosure: ((UIAlertAction) -> ())?,controllerStyle:UIAlertController.Style, actionTwoClosure:((UIAlertAction) -> ())?,actionOneStyle:UIAlertAction.Style,actionTwoStyle:UIAlertAction.Style?) {
       
        let alertController = UIAlertController(title: controllerTitle, message: controllerMessage, preferredStyle: controllerStyle)
        
        let actionOne = UIAlertAction(title: actionOneTitle, style:actionOneStyle, handler: actionOneClosure)
        
        let cancel = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        
        
        if actionTwoTitle != nil {
            let actionTwo = UIAlertAction(title: actionTwoTitle, style: actionTwoStyle!, handler: actionTwoClosure)
            
            alertController.addAction(actionOne)
            alertController.addAction(actionTwo)
            alertController.addAction(cancel)
            present(alertController,animated: true)
        } else {
       
        alertController.addAction(actionOne)
        alertController.addAction(cancel)
        present(alertController,animated: true)
        
    }
    }
}

extension UIBarButtonItem {

    static func barButton(_ target: Any?, action: Selector, imageName: String?, image:UIImage?,systemImageName:String?) -> UIBarButtonItem {
        let button = UIButton(type: .custom)
        
        
        
        if let imageName = imageName {
        button.setImage(UIImage(named: imageName), for: .normal)
        }
    
       if let image = image {
            button.setImage(image, for: .normal)
        }
        
        if let systemImageName = systemImageName {
            button.setImage(UIImage(systemName: systemImageName), for: .normal)
        }
        button.addTarget(target, action: action, for: .touchUpInside)
        button.setImage(UIImage(), for: .disabled)
        let barButtonItem = UIBarButtonItem(customView: button)
        barButtonItem.customView?.translatesAutoresizingMaskIntoConstraints = false
        barButtonItem.customView?.heightAnchor.constraint(equalToConstant: 28).isActive = true
        barButtonItem.customView?.widthAnchor.constraint(equalToConstant: 28).isActive = true
        
     

        return barButtonItem
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
    
    var isValidEmail: Bool {
        
        // this pattern requires that an email use the following format:
        // [something]@[some domain].[some tld]
        let validEmailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        
        let emailPredicate = NSPredicate(format:"SELF MATCHES %@", validEmailRegEx)
        return emailPredicate.evaluate(with: self)
    }
    
    
    var isValidPassword: Bool {
        
        //this pattern requires that a password has at least one capital letter, one number, one lower case letter, and is at least 8 characters long
        //let validPasswordRegEx =  "(?=.*[A-Z])(?=.*[0-9])(?=.*[a-z]).{8,}"
        
        //this pattern requires that a password be at least 8 characters long
        let validPasswordRegEx =  "[A-Z0-9a-z!@#$&*.-]{8,}"
        let passwordPredicate = NSPredicate(format: "SELF MATCHES %@", validPasswordRegEx)
        return passwordPredicate.evaluate(with: self)
    }
    
    var isConfirmPasswordValid: Bool {
        //this pattern requires that a password has at least one capital letter, one number, one lower case letter, and is at least 8 characters long
        //let validPasswordRegEx =  "(?=.*[A-Z])(?=.*[0-9])(?=.*[a-z]).{8,}"
        
        //this pattern requires that a password be at least 8 characters long
        let validPasswordRegEx =  "[A-Z0-9a-z!@#$&*.-]{8,}"
        let passwordPredicate = NSPredicate(format: "SELF MATCHES %@", validPasswordRegEx)
        return passwordPredicate.evaluate(with: self)
    }
    
}
