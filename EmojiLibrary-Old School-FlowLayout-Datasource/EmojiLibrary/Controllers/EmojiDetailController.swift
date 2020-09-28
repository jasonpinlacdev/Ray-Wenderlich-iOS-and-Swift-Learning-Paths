import UIKit

class EmojiDetailController: UIViewController {
  
  var emoji: String? {
    // didSet does not get called when the variable is initailized.
    didSet {
      if let label = label {
        print("didset block of code executed")
        label.text = emoji
      }
    }
  }
  
  @IBOutlet weak var label: UILabel!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    label.text = emoji
  }
    
}
