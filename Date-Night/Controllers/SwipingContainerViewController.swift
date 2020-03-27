
import UIKit

protocol SwipingContainerViewControllerDelegate:class {
  func swipingViewControllerDidEndDeceleratingOnPage(swippingViewController: SwipingContainerViewController, page: Int)
}


class SwipingContainerViewController: UIViewController {

  weak var swipingViewControllerDelegate: SwipingContainerViewControllerDelegate?
  
  var viewControllers: [UIViewController] = [] {
    willSet {
      for viewController in viewControllers {
     
        viewController.view.removeFromSuperview()
      }
    }
    didSet {
      for viewController in viewControllers {
        scrollView.addSubview(viewController.view)
        viewController.viewWillAppear(true)
      }
    }
  }
  
  var scrollView: UIScrollView = UIScrollView()
    

  var currentPage: Int {
    print(scrollView.contentOffset.x)
    return Int(scrollView.contentOffset.x / scrollView.bounds.width)
  }

  //MARK: UIViewController Overrides
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setUpScrollView()
  }
  
  override func viewWillLayoutSubviews() {
    super.viewWillLayoutSubviews()
    scrollView.frame = view.bounds
    calculateScrollViewContentSize()
    positionViewControllers()
    setUpScrollView()
    setStartingViewController()
  }

  //MARK: Layout
  
  func calculateScrollViewContentSize() {
    let scrollViewContentSizeWidth = scrollView.bounds.width * CGFloat(viewControllers.count)
    let scrollViewContentSize = CGSize(width: scrollViewContentSizeWidth,
                                       height: scrollView.bounds.height)
    scrollView.contentSize = scrollViewContentSize
  }
  
  func positionViewControllers() {
    guard viewControllers.count > 0 else { return }
    for (index, viewController) in viewControllers.enumerated() {
      let size = view.bounds.size
      let minX = xOffsetForViewController(index: index)
      viewController.view.frame =
        CGRect(x: minX,
               y: 0,
               width: size.width,
               height: scrollView.frame.height)
    }
  }
  
  func xOffsetForViewController(index: Int) -> CGFloat {
    guard index < viewControllers.count else { fatalError() }
    return CGFloat(index) * view.bounds.width
  }
  
  func setUpScrollView() {
    
    scrollView.alwaysBounceVertical = false
    scrollView.backgroundColor = StyleGuide.AppColors.backgroundColor
    scrollView.isPagingEnabled = true
    view.addSubview(scrollView)
    scrollView.delegate = self
  
  
    
    
      }
    
    func navigateToViewController(index: Int) {

         let contentOffset = CGPoint(x: xOffsetForViewController(index: index ), y: 0)
         scrollView.contentOffset = contentOffset


       }
  
    func setStartingViewController() {
    
        let contentOffset = CGPoint(x: xOffsetForViewController(index: 1 ), y: 0)
                 scrollView.contentOffset = contentOffset
        
    }
    }
    
extension SwipingContainerViewController: UIScrollViewDelegate {
  func scrollViewDidScroll(_ scrollView: UIScrollView) {
  
    }
  
  func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
    //    print(#function)
    
    swipingViewControllerDelegate?
      .swipingViewControllerDidEndDeceleratingOnPage(swippingViewController: self,
                                       page: currentPage)
  }
}
