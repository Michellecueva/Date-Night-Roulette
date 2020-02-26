
import UIKit

class ShakeGestureVC: UIViewController {
    
    var eventIndexCount = 0
    var demonstration = DummyData()
    
    var shakeView = ShakeGestureView()
    var eventView = ShakeEventView()
    var demoData = DummyData()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(shakeView)
        view.backgroundColor = .black
        self.navigationController?.navigationBar.topItem?.title = "Shake"
    }
    
    func shakeTheEvent() {
        // WIP This function is intended to shift to the next event and will go inside the motionBegan pre-built function
        shakeView.shakeEventView.shakeImage.image = UIImage(named: demoData.eventObj.last?.image ?? "")
        shakeView.shakeEventView.shakeInfoDetailTextView.text = demoData.eventObj.last?.longDesc ?? ""
//        shakeView.shakeEventView.shakeInfoDetailTextView.text = demoData.eventObj.last?.titleLabel ?? ""
//        shakeView.shakeEventView.shake
        shakeView.layoutIfNeeded()
        demoData.eventObj.popLast()
        print("shake event func called")
    }

// load in my array of events in viewDidLoad, and add the info from the last index to the shakeview
// after I shake the phone, let's call a func that does these things:
// remove last index of array of events (popLast)
// (not important right now) save info from that index to firebase.
// update the shakeview with the info from the event that is NOW at the last index
// when there are no more events, deal with it, user!

    override func motionBegan(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
        shakeTheEvent()
            print("Shake has happened")
    }
    
//    override func motionBegan(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
//
//        // Add code when motion begins -- probably could be some kind of animation
//        shakeTheEvent()
//        print("Shake has happened")
//
//    }
    
    override func motionEnded(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
        
        // Add code for when motion stops --
    }
    
    
}

struct DummyData {
    var eventObj =
        [EventObj(titleLabel: "The Lion King", image: "LIONKING-superJumbo", longDesc: "Based on the 1994 Disney animated feature film of the same name and William Shakespeare's Hamlet, The Lion King is the story of Simba, an adventurous and energetic lion cub who is next in line to be king of the Pride Lands, a thriving and beautiful region in the African savanna." ),
         EventObj(titleLabel: "Goldfinger Live", image: "concert-2", longDesc: "Goldfinger is an American punk rock and ska punk band from Los Angeles, California, formed in 1994. In their early years the band is widely considered to have been a contributor to the movement of third-wave ska, a mid-1990s revitalization in the popularity of ska." ),
         EventObj(titleLabel: "Jazz night", image: "jazzNight", longDesc: "Jazz night featuring our beloved, phenomenal saxophonist, Kenn Friedman. ... Our three-story café allows having an eclectic experience varying from a lively Jazz experience on the second floor (the main venue) to a relaxing Jazz music background on the first and third floor." ),
         EventObj(titleLabel: "Electric Daisy Carnival", image: "festival", longDesc: "Electric Daisy Carnival, commonly known as EDC, is the largest electronic dance music festival in North America. The annual flagship event is now held in May, at the Las Vegas Motor Speedway."),
         EventObj(titleLabel: "Webster Hall", image: "danceNight", longDesc: "Webster Hall. The landmarked Webster Hall in the East Village serves as a performance space during the week and nightclub on the weekends, in addition to hosting private events. Three floors of entertainment space, including lounges, can accommodate parties from 100 to 2,500 people."),
         EventObj(titleLabel: "Bill Burr", image: "comedyShow", longDesc: "Massachusetts native Bill Burr is a standup comedian, podcaster, and actor best known for his sardonic observational humor. Burr studied radio at Emerson College in the early '90s, and did his first standup show as a student in 1992.")]
}

struct EventObj {
    let titleLabel: String
    let image: String
    let longDesc: String
}
