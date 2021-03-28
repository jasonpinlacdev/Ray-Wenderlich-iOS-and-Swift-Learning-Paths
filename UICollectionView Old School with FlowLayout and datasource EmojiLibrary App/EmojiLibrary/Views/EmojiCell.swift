import UIKit

class EmojiCell: UICollectionViewCell {
    
    static let reuseId = String(describing: EmojiCell.self)
    
    @IBOutlet weak var emojiLabel: UILabel!
    
    // this added property keeps track of the visible cells on the screen when the VC goes into edit mode.
    var isEditing: Bool = false

//    // overriden to add a property observer that changes the cells color when selected either red or grey if the VC is in edit mode or not
    override var isSelected: Bool {
        didSet {
            if isEditing {
                self.contentView.backgroundColor = isSelected ? .systemRed : .systemGroupedBackground
            } else {
                self.contentView.backgroundColor = .systemGroupedBackground
            }
        }
    }

    
    func set(emoji: String) {
        emojiLabel.text = emoji
    }
}
