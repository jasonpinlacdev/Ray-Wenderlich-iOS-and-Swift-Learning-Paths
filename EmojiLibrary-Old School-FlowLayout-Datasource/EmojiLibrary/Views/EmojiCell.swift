
import UIKit

class EmojiCell: UICollectionViewCell {
  static let reuseIdentifier = String(describing: EmojiCell.self)
    
  @IBOutlet weak var emojiLabel: UILabel!
    
    var isEditing = false
    
    override var isSelected: Bool {
        didSet {
            if isEditing {
                self.contentView.backgroundColor = isSelected ? UIColor.systemRed.withAlphaComponent(0.5) : UIColor.systemBackground
            } else {
                self.contentView.backgroundColor = UIColor.systemGroupedBackground
            }
        }
    }
    
    
}
