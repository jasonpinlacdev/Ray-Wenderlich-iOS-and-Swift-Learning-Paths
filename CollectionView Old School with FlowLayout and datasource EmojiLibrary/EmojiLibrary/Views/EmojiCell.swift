import UIKit

class EmojiCell: UICollectionViewCell {
    
    static let reuseId = String(describing: EmojiCell.self)
    
    @IBOutlet weak var emojiLabel: UILabel!
    
    func set(emoji: String) {
        emojiLabel.text = emoji
    }
}
