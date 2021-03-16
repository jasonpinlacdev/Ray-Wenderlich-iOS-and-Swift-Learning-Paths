import UIKit

class EmojiDetailViewController: UIViewController {

    @IBOutlet var emojiLabel: UILabel!
    
    var emoji: String?
    
    // 3rd way - @IBSegueAction + init?(data, coder)
    init?(emoji: String, coder: NSCoder) {
        self.emoji = emoji
        super.init(coder: coder)
    }
    
    // 4th way - progammatically with storyboard.instantiate VC
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        emojiLabel.text = emoji
    }
    
}
