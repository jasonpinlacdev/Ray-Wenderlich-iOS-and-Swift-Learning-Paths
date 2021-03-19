import UIKit

class EmojiCollectionViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    let dataSource = EmojiCollectionDataSource()
    let delegate = EmojiCollectionDelegate(numberOfItemsPerRow: 7, interItemSpacing: 5.0)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.dataSource = self.dataSource
        collectionView.delegate = self.delegate
        collectionView.register(EmojiCollectionHeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: EmojiCollectionHeaderView.reuseId)
        
        navigationItem.leftBarButtonItem = editButtonItem
    }
    
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        if self.isEditing && identifier == "ShowEmojiDetailViewController" { return false }
        return true
    }
    
    // overriden to work with our EmojiCell's overriden isSelected property and our added isEditing property
    override func setEditing(_ editing: Bool, animated: Bool) {
        super.setEditing(editing, animated: animated)
        
        // all visible cells have their isEditing property set to true
        let indexPathsOnScreen = collectionView.indexPathsForVisibleItems
        indexPathsOnScreen.forEach {
            guard let cell = collectionView.cellForItem(at: $0) as? EmojiCell else { return }
            cell.isEditing = editing
        }
        
        if editing == false {
            collectionView.indexPathsForSelectedItems?.compactMap {$0}.forEach {
                collectionView.deselectItem(at: $0, animated: true)
            }
        }
        
    }
    

    @IBAction func addNewEmoji(_ sender: Any) {
        let (category, newEmoji) = Emoji.randomEmoji()
        dataSource.addEmoji(newEmoji, to: category)
//        collectionView.reloadData()
        let itemCount = collectionView.numberOfItems(inSection: 0)
        let insertedIndexPath = IndexPath(item: itemCount, section: 0)
        collectionView.insertItems(at: [insertedIndexPath])
        
    
    }
    
    // MARK: - 1st way to handle showing detail using segue + prepare()
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowEmojiDetailViewController" {
            guard let cell = sender as? EmojiCell,
                  let indexPath = collectionView.indexPath(for: cell),
                  let emojiDetailViewController = segue.destination as? EmojiDetailViewController
            else { fatalError() }
            let category = Emoji.shared.sections[indexPath.section]
            let emoji = Emoji.shared.data[category]?[indexPath.item]
            emojiDetailViewController.emoji = emoji
        }
    }
    
    // MARK: - 2nd way to handle showing detail using segue + performSegue() + prepare()
//        override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//            if segue.identifier == "ShowEmojiDetailViewController" {
//                guard let emoji = sender as? String else { fatalError() }
//                guard let emojiDetailViewController = segue.destination as? EmojiDetailViewController else { fatalError() }
//                emojiDetailViewController.emoji = emoji
//            }
//        }

    // MARK: - 3rd way to handle showing detail using iOS 13+ @IBSegueAction + init?(data, coder)
//    @IBSegueAction func showEmojiDetailViewController(_ coder: NSCoder) -> EmojiDetailViewController? {
//        guard let indexPath = collectionView.indexPathsForSelectedItems?[0] else { fatalError() }
//        let category = Emoji.shared.sections[indexPath.section]
//        let emoji = Emoji.shared.data[category]![indexPath.item]
//        return EmojiDetailViewController(emoji: emoji, coder: coder)
//    }
    

}



