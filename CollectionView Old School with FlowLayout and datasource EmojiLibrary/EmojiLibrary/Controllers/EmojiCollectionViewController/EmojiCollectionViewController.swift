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
    }
    
  
    
}



