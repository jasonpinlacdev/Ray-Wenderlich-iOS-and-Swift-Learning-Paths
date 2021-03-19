import UIKit

class EmojiCell: UICollectionViewCell {
    
    static let reuseId = String(describing: EmojiCell.self)
    
    @IBOutlet weak var emojiLabel: UILabel!
    
    var isEditing = false
    
    // overriden to add a property observer that changes the cells color when selected either red or grey if the VC is in edit mode or not
    override var isSelected: Bool {
        didSet {
            if isEditing {
                contentView.backgroundColor = isSelected ? UIColor.systemRed : UIColor.systemGroupedBackground
            } else {
                contentView.backgroundColor = UIColor.systemGroupedBackground
            }
        }
    }
    
    func set(emoji: String) {
        emojiLabel.text = emoji
    }
}
