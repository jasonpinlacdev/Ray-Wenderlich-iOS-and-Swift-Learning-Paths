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
    

    // MARK: - 1st way to handle showing detail using segue + prepare()
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        if segue.identifier == "ShowEmojiDetailViewController" {
//            guard let cell = sender as? EmojiCell,
//                  let indexPath = collectionView.indexPath(for: cell),
//                  let emojiDetailViewController = segue.destination as? EmojiDetailViewController
//            else { fatalError() }
//            let category = Emoji.shared.sections[indexPath.section]
//            let emoji = Emoji.shared.data[category]?[indexPath.item]
//            emojiDetailViewController.emoji = emoji
//        }
//    }
    
    // MARK: - 2nd way to handle showing detail using segue + performSegue() + prepare()
    //    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    //        if segue.identifier == "ShowEmojiDetailViewController" {
    //            guard let emoji = sender as? String else { fatalError() }
    //            guard let emojiDetailViewController = segue.destination as? EmojiDetailViewController else { fatalError() }
    //            emojiDetailViewController.emoji = emoji
    //        }
    //    }

    // MARK: - 3rd way to handle showing detail using iOS 13+ @IBSegueAction + init?(data, coder)
//    @IBSegueAction func showEmojiDetailViewController(_ coder: NSCoder) -> EmojiDetailViewController? {
//        guard let indexPath = collectionView.indexPathsForSelectedItems?[0] else { fatalError() }
//        let category = Emoji.shared.sections[indexPath.section]
//        let emoji = Emoji.shared.data[category]![indexPath.item]
//        return EmojiDetailViewController(emoji: emoji, coder: coder)
//    }
    

}



