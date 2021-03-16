import UIKit

class EmojiDetailViewController: UIViewController {

    @IBOutlet var emojiLabel: UILabel!
    
    var emoji: String
    
    init?(emoji: String, coder: NSCoder) {
        self.emoji = emoji
        super.init(coder: coder)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        emojiLabel.text = emoji
    }
}
