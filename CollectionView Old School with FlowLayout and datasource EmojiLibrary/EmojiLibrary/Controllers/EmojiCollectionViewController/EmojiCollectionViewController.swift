import UIKit

class EmojiCollectionViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet var addButton: UIBarButtonItem!
    @IBOutlet var deleteButton: UIBarButtonItem!
    
    let dataSource = EmojiCollectionDataSource()
    let delegate = EmojiCollectionDelegate(numberOfItemsPerRow: 7, interItemSpacing: 5.0)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.dataSource = self.dataSource
        collectionView.delegate = self.delegate
        collectionView.register(EmojiCollectionHeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: EmojiCollectionHeaderView.reuseId)
        navigationItem.leftBarButtonItem = editButtonItem
        collectionView.allowsMultipleSelection = true
    }
    
    
    // override shouldPerformSegue to check to see if the vc is in editMode or not
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        if self.isEditing && identifier == "ShowEmojiDetailViewController" {
            return false
        }
        return true
    }

    // override setEditing to work with our EmojiCell's overriden isSelected property and our added isEditing property
    override func setEditing(_ editing: Bool, animated: Bool) {
        super.setEditing(editing, animated: animated)
        
        addButton.isEnabled = !editing
        deleteButton.isEnabled = editing
        
        let visibleIndexes = collectionView.indexPathsForVisibleItems
        visibleIndexes.forEach {
            guard let emojiCell = collectionView.cellForItem(at: $0) as? EmojiCell else { fatalError() }
            emojiCell.isEditing = editing
        }
        
        if !editing {
            guard let indexPathsForSelectedItems = collectionView.indexPathsForSelectedItems else { fatalError() }
            indexPathsForSelectedItems.forEach {
                collectionView.deselectItem(at: $0, animated: true)
            }
        }
    }
    
    @IBAction func addEmoji(_ sender: UIBarButtonItem) {
        let (category, emoji) = Emoji.randomEmoji()
        dataSource.addEmoji(emoji, to: category)
//        collectionView.reloadData()
        let itemPosition = Emoji.shared.data[category]!.count - 1
        let sectionPosition = Emoji.shared.sections.firstIndex(of: category)!
        let indexPathOfNewEmoji = IndexPath(item: itemPosition, section: sectionPosition)
        collectionView.insertItems(at: [indexPathOfNewEmoji])
    }
    
    @IBAction func deleteEmoji(_ sender: UIBarButtonItem) {
        guard let indexPathsOfSelectedCells = collectionView.indexPathsForSelectedItems else { fatalError() }
        dataSource.deleteEmojis(at: indexPathsOfSelectedCells)
        collectionView.deleteItems(at: indexPathsOfSelectedCells)
    }
    
    // MARK: - 1st way to handle showing detail using segue + prepare()
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowEmojiDetailViewController" {
            guard let emojiDetailViewController = segue.destination as? EmojiDetailViewController,
                  let cell = sender as? EmojiCell,
                  let indexPath = collectionView.indexPath(for: cell)
            else { fatalError() }
            
            let category = Emoji.shared.sections[indexPath.section]
            let emoji = Emoji.shared.data[category]?[indexPath.item]
            emojiDetailViewController.emoji = emoji
            
            guard let indexPathsForSelectedItems = collectionView.indexPathsForSelectedItems else { fatalError() }
            indexPathsForSelectedItems.forEach {
                collectionView.deselectItem(at: $0, animated: true)
            }
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



