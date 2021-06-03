import UIKit

class PhotosViewController: UIViewController {
  
  @IBOutlet var collectionView: UICollectionView!

  let dataSource = PhotosDataSource()
  let delegate = PhotosDelegate(interItemSpacing: 1.0, itemsPerRow: 3.0)
  
  override func viewDidLoad() {
    super.viewDidLoad()
    collectionView.dataSource = dataSource
    collectionView.delegate = delegate
  }

  

  
  
  
  
  
  
}
