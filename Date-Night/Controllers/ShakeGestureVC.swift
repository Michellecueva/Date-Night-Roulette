
import UIKit


//shake gesture only works on first responder
class ShakeGestureVC: UIViewController {
    
    var eventIndexCount = 0
    
    var pageControl:UIPageControl = UIPageControl(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
    
    var shakeView = ShakeGestureView()
    var fbEvents:[FBEvents] = [] {
        didSet {
            print(fbEvents.count)
            setUpView()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(shakeView)
        view.backgroundColor = .black
       
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.makeNavBarTranslucent()
        configurePageControl()
    }
    
    override func viewDidAppear(_ animated:Bool) {
        super.viewDidAppear(animated)
      
    }
    
    func shakeTheEvent() {
        // WIP This function is intended to shift to the next event and will go inside the motionBegan pre-built function
setUpView()
        shakeView.layoutIfNeeded()
        fbEvents.popLast()
        pageControl.currentPage = pageControl.currentPage + 1
        print("shake event func called")
        
    }
    
  private func configurePageControl() {
    self.pageControl.numberOfPages = fbEvents.count
        self.pageControl.currentPage = 0
        self.pageControl.tintColor = #colorLiteral(red: 0.9164920449, green: 0.7743749022, blue: 0.9852260947, alpha: 1)
        self.pageControl.pageIndicatorTintColor = UIColor.white
        self.pageControl.currentPageIndicatorTintColor = #colorLiteral(red: 0.9767183661, green: 0.2991916835, blue: 1, alpha: 1)
        pageControl.isUserInteractionEnabled = false
        pageControl.translatesAutoresizingMaskIntoConstraints = false
        
        navigationItem.titleView = pageControl
        pageControl.transform = CGAffineTransform(scaleX: 1.5, y: 1.5)
        
    }
    
    private func setUpView() {
        guard let lastEvent = self.fbEvents.last else {return}
        if let image = lastEvent.imageURL {

       //remember to stop user interaction until image finishes loading
            ImageHelper.shared.getImage(urlStr: image) { [weak self](result) in
        DispatchQueue.main.async {
            
        
        switch result {
      case .failure(let error):
       print(error)
       self?.shakeView.shakeEventView.setUpImage(from:lastEvent , image: UIImage(systemName: "photo")!)
      case .success(let image):
        
        self?.shakeView.shakeEventView.setUpImage(from: lastEvent, image: image)
      }
     }
            }
    } else {
            self.shakeView.shakeEventView.setUpImage(from:lastEvent , image: UIImage(systemName: "photo")!)
    }
}

    override func becomeFirstResponder() -> Bool {
        return true
    }
    
    override func motionBegan(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
        shakeTheEvent()
            print("Shake has happened")
    }
    
        override func motionEnded(_ motion: UIEvent.EventSubtype, with event: UIEvent?){
         if motion == .motionShake
         {
               print("Shake Gesture Detected")
               //show some alert here
         }
    }
}
