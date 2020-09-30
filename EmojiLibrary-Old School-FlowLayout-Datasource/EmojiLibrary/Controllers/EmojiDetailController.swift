import UIKit

class EmojiDetailController: UIViewController {
    
    @IBOutlet weak var label: UILabel!
    
    var emoji: String? {
        didSet {
            if let label = label {
                label.text = emoji
            }
        }
    }
    
//    init?(coder: NSCoder, emoji: String) {
//        self.emoji = emoji
//        super.init(coder: coder)
//    }
    
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        label.text = emoji
    }
    
}
