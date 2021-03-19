import UIKit

class EmojiDetailViewController: UIViewController {

    @IBOutlet var emojiLabel: UILabel!
    
    var emoji: String?
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    // MARK: - 3rd way @IBSegueAction + init?(data, coder) -
//    init?(emoji: String, coder: NSCoder) {
//        self.emoji = emoji
//        super.init(coder: coder)
//    }
    
    // MARK: - 4th way progammatically with storyboard.instantiate VC -
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        emojiLabel.text = emoji
    }
    
}
