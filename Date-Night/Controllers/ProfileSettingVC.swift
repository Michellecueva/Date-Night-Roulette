import UIKit

class ProfileSettingVC: UIViewController {

    var profileSetting = ProfileSettingView()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        view.addSubview(profileSetting)
    }
    


}
