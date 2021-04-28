
import UIKit

class EmojiCollectionViewController: UIViewController {
  
  @IBOutlet weak var collectionView: UICollectionView!
  
  @IBOutlet var addButton: UIBarButtonItem!
  @IBOutlet var deleteButton: UIBarButtonItem!
  
  let dataSource = EmojiCollectionDataSource()
  let delegate = EmojiCollectionDelegateFlowLayout(numberOfItemsPerRow: 6, interItemSpacing: 3.0)
  
  override func viewDidLoad() {
    super.viewDidLoad()
    title = "Emoji App"
    navigationItem.leftBarButtonItem = editButtonItem
    collectionView.allowsMultipleSelection = true
    collectionView.register(EmojiSectionHeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: EmojiSectionHeaderView.reuseIdentifier)
    dataSource.controller = self
    collectionView.dataSource = dataSource
    collectionView.collectionViewLayout = UICollectionViewFlowLayout()
    collectionView.delegate = delegate
    
  }
  
  override func viewWillAppear(_ animated: Bool) {
    collectionView.indexPathsForSelectedItems?.forEach {
      collectionView.deselectItem(at: $0, animated: true)
    }
  }
  
  override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
    return isEditing ? false : true
  }
  
  
  override func setEditing(_ editing: Bool, animated: Bool) {
    super.setEditing(editing, animated: animated)
    
    collectionView.indexPathsForVisibleItems.forEach {
      let cell = collectionView.cellForItem(at: $0) as? EmojiCell
      cell?.isInEditMode = editing
      // ALSO WHEN THE CELL IS BEING DEQUEUED WE ASSIGN THIS isInEditMode PROPERTY TO THE VC's EDIT STATE.
    }
    
    addButton.isEnabled = !editing
    deleteButton.isEnabled = editing
    
    if !editing {
      collectionView.indexPathsForSelectedItems?.forEach { collectionView.deselectItem(at: $0, animated: true) }
    }
  }
  
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    if segue.identifier == "ShowEmojiDetailController" {
      guard let emojiDetailController = segue.destination as? EmojiDetailController else { return }
      guard let indexPath = collectionView.indexPathsForSelectedItems?[0] else { return}
      let category = Emoji.shared.sections[indexPath.section]
      let emoji = Emoji.shared.data[category]?[indexPath.item]
      emojiDetailController.emoji = emoji
    }
  }
  
  @IBAction func addEmoji(_ sender: Any) {
    let (category, emoji) = Emoji.randomEmoji()
    dataSource.add(emoji: emoji, to: category)
    let sectionPosition = Emoji.shared.sections.firstIndex(of: category)!
    let itemPosition = Emoji.shared.data[category]!.count - 1
    let indexPath = IndexPath(item: itemPosition, section: sectionPosition)
    collectionView.insertItems(at: [indexPath])
  }
  
  @IBAction func deleteEmoji(_ sender: Any) {
    guard let indexPathsOfEmojiToDelete = collectionView.indexPathsForSelectedItems else { return }
    dataSource.deleteEmojis(at: indexPathsOfEmojiToDelete)
    collectionView.deleteItems(at: indexPathsOfEmojiToDelete)
  }
  

  
}
