import UIKit

class EmojiCollectionViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    let dataSource = EmojiCollectionViewDataSource()
    lazy var delegate = EmojiCollectionViewDelegate(numberOfItemsPerRow: 7, interItemSpacing: 5.0)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.dataSource = self.dataSource
        collectionView.delegate = self.delegate
        collectionView.register(EmojiCollectionHeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: EmojiCollectionHeaderView.reuseId)
        delegate.controller = self
    }
    
    @IBSegueAction func showEmojiDetailViewController(_ coder: NSCoder) -> EmojiDetailViewController? {
        guard let indexPath = collectionView.indexPathsForSelectedItems?[0] else { fatalError() }
                   let sectionCategory = Emoji.shared.sections[indexPath.section]
                   let emoji = Emoji.shared.data[sectionCategory]![indexPath.item]
        return EmojiDetailViewController(emoji: emoji, coder: coder)
    }
    //    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        guard let indexPath = collectionView.indexPathsForSelectedItems?[0] else { fatalError() }
//        if segue.identifier == "ShowEmojiDetailViewController" {
//            guard let emojiDetailViewController = segue.destination as? EmojiDetailViewController else { fatalError() }
//            let sectionCategory = Emoji.shared.sections[indexPath.section]
//            let emoji = Emoji.shared.data[sectionCategory]![indexPath.item]
//            emojiDetailViewController.emoji = emoji
//        }
//    }
    
  
    
}



