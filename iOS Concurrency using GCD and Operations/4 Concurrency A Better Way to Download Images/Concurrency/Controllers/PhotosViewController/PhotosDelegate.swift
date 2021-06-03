import UIKit

class PhotosDelegate: NSObject {
  
  let interItemSpacing: CGFloat
  let itemsPerRow: CGFloat
  
  var cellSize: CGFloat?
  
  
  init(interItemSpacing: CGFloat, itemsPerRow: CGFloat) {
    self.interItemSpacing = interItemSpacing
    self.itemsPerRow = itemsPerRow
    super.init()
  }
  
  
}

extension PhotosDelegate: UICollectionViewDelegateFlowLayout {
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    let collectionViewWidth: CGFloat = collectionView.bounds.size.width
    let availableWidth: CGFloat = collectionViewWidth - (itemsPerRow * interItemSpacing) - interItemSpacing
    let itemWidth: CGFloat = availableWidth/itemsPerRow
    return CGSize(width: itemWidth, height: itemWidth)
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
    return interItemSpacing
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
    return interItemSpacing
  }
}
