
import UIKit

class EmojiCell: UICollectionViewCell {
  static let reuseIdentifier = String(describing: EmojiCell.self)
    
  @IBOutlet weak var emojiLabel: UILabel!
  
  var isInEditMode = false
  
  override var isSelected: Bool {
    didSet {
      self.contentView.backgroundColor = isSelected && isInEditMode ? .systemRed : .lightGray
    }
  }

  required init?(coder: NSCoder) {
    super.init(coder: coder)
    contentView.backgroundColor = .lightGray
  }
}
