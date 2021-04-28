
import UIKit

class EmojiDetailController: UIViewController {
  
  var emoji: String?
  
  @IBOutlet weak var textLabel: UILabel!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    textLabel.text = emoji
  }
  
}
