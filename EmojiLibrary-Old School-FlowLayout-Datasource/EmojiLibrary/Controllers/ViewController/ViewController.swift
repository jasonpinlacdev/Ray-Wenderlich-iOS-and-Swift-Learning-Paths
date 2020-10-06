import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    
    // MARK: - you can abstract the datasource and delegate protol adoptions into their own objects to fulfill the single responsibility per class rule -
    let dataSource = EmojiCollectionViewDataSource()
    let delegate = EmojiCollectionViewDelegate(numberOfItemsPerRow: 10, minimumInterItemSpacing: 5)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.leftBarButtonItem = editButtonItem
        
        // this gives the delgate object a reference to our viewController. create this property in the delegegate class and make it a weak property.
        delegate.viewController = self
        collectionView.dataSource = dataSource
        collectionView.delegate = delegate
        //        collectionView.dataSource = self
        //        collectionView.delegate = self
    }
    
    override func setEditing(_ editing: Bool, animated: Bool) {
        super.setEditing(editing, animated: animated)
        
        collectionView.indexPathsForVisibleItems.forEach { indexPath in
            guard let emojiCell = collectionView.cellForItem(at: indexPath) as? EmojiCell else { return }
            emojiCell.isEditing = editing
        }
        
        if !editing {
            collectionView.indexPathsForSelectedItems?.compactMap({ $0 }).forEach({ indexPath in
                collectionView.deselectItem(at: indexPath, animated: true)
            })
        }
    }
    
    @IBAction func addEmoji(_ sender: Any) {
        let (category, emoji): (Emoji.Category, String) = Emoji.randomEmoji()
        guard var emojiCategoryData = Emoji.shared.data[category] else { return }
        
        emojiCategoryData.append(emoji)
        Emoji.shared.data.updateValue(emojiCategoryData, forKey: category)
        
        let indexPathItem: Int = (Emoji.shared.data[category]?.count)! - 1
        let indexPathSection: Int = Emoji.shared.sections.firstIndex(of: category)!
        let indexPath = IndexPath(item: indexPathItem, section: indexPathSection)
        collectionView.insertItems(at: [indexPath])
    }
    
    
    // MARK: - 2 different ways of having a segue pass data to the the viewController being segued to. MAKE SURE YOU CLICK HOLD DRAG THE COLLECTION VIEW CELL TO THE DESIRED VIEWCONTROLLER IN ORDER TO CREATE THE SEGUE. IBSegueAction is new. prepare method is older and the segue on IB has the have a storyboard ID given to it. Remember programmatically you can also pass data using delegate/protocol or closures to the DetailViewController for its viewDidLoad method-
    
    //    @IBSegueAction func showEmojiDetail(_ coder: NSCoder) -> EmojiDetailController? {
    //        guard let indexPath = collectionView.indexPathsForSelectedItems?[0],
    //              let emoji = Emoji.shared.data[Emoji.shared.sections[indexPath.section]]?[indexPath.row]
    //              else { return nil }
    //        return EmojiDetailController(coder: coder, emoji: emoji)
    //    }
    
    //    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    //        guard segue.identifier == "ShowEmojiDetail",
    //              let emojiCell = sender as? EmojiCell,
    //              let emojiDetailController = segue.destination as? EmojiDetailController,
    //              let indexPath = collectionView.indexPath(for: emojiCell),
    //              let emoji = Emoji.shared.getEmoji(at: indexPath)
    //        else { fatalError() }
    //
    //        emojiDetailController.emoji = emoji
    //    }
    
    //    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
    //        if isEditing && identifier == "ShowEmojiDetail" {
    //            return false
    //        } else {
    //            return true
    //        }
    //    }
    

}

//extension ViewController: UICollectionViewDataSource {
//    func numberOfSections(in collectionView: UICollectionView) -> Int {
//        return Emoji.shared.sections.count
//    }
//
//    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        let categoryKey = Emoji.shared.sections[section]
//        return Emoji.shared.data[categoryKey]?.count ?? 0
//    }
//
//    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: EmojiCell.reuseIdentifier, for: indexPath) as? EmojiCell else { fatalError() }
//        cell.emojiLabel.text = Emoji.shared.getEmoji(at: indexPath)
//        return cell
//    }
//
//    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
//        guard let sectionView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: EmojiSectionHeaderCollectionReusableView.reuseIdentifier, for: indexPath) as? EmojiSectionHeaderCollectionReusableView else { fatalError("Failed to dequeue EmojiSectionheaderCollectionReusableView.") }
//        sectionView.sectionLabel.text = Emoji.shared.sections[indexPath.section].rawValue
//        return sectionView
//    }
//
//}
//
//extension ViewController: UICollectionViewDelegateFlowLayout {
//
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        let numberOfItemsPerRow: CGFloat = 10.0
//        let minimumInterItemSpacing: CGFloat = 5.0
//
//        let maxScreenWidth = UIScreen.main.bounds.width
//        let totalSpacing = minimumInterItemSpacing * numberOfItemsPerRow
//        let itemWidth = (maxScreenWidth - totalSpacing) / numberOfItemsPerRow
//        return CGSize(width: itemWidth, height: itemWidth)
//    }
//
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
//        let minimumInterItemSpacing: CGFloat = 5.0
//        return minimumInterItemSpacing
//    }
//
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
//        if section == 0 {
//            return UIEdgeInsets(top: 0, left: 0, bottom: 5.0/2, right: 0)
//        }
//        let minimumInterItemSpacing: CGFloat = 5.0
//        return UIEdgeInsets(top: minimumInterItemSpacing/2, left: 0, bottom: minimumInterItemSpacing/2, right: 0)
//    }
//
//    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        guard let emojiDetailController = storyboard?.instantiateViewController(identifier: "EmojiDetail") as? EmojiDetailController else { fatalError() }
//        let emojiCategoryKey = Emoji.shared.sections[indexPath.section]
//        emojiDetailController.emoji = Emoji.shared.data[emojiCategoryKey]?[indexPath.row]
//        navigationController?.pushViewController(emojiDetailController, animated: true)
//    }
//
//}

