//
//  EmojiCollectionDelegateFlowLayout.swift
//  EmojiLibrary
//
//  Created by Jason Pinlac on 4/26/21.
//

import UIKit

class EmojiCollectionDelegateFlowLayout: NSObject {

  let numberOfItemsPerRow: CGFloat
  let interItemSpacing: CGFloat
  
  weak var viewController: UIViewController?
  
  init(numberOfItemsPerRow: CGFloat, interItemSpacing: CGFloat) {
    self.numberOfItemsPerRow = numberOfItemsPerRow
    self.interItemSpacing = interItemSpacing
    super.init()
  }
  
}


extension EmojiCollectionDelegateFlowLayout: UICollectionViewDelegateFlowLayout {
  
  // delegate flow layout is useful in creating a dynamic item size that adapts to the screen size. This is nice because it allows you to keep the number of items per row consistent regardless of screen size.

  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    let collectionViewWidth = collectionView.bounds.width
    let spacing = numberOfItemsPerRow * interItemSpacing
    let itemWidth = (collectionViewWidth - spacing) / numberOfItemsPerRow
    return CGSize(width: itemWidth, height: itemWidth)
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
    return interItemSpacing
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
    return interItemSpacing
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
    return section == 0 ? UIEdgeInsets(top: 0, left: 0, bottom: interItemSpacing*2, right: 0) : UIEdgeInsets(top: interItemSpacing*2, left: 0, bottom: interItemSpacing*2, right: 0)
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
    
    let collectionViewWidth = collectionView.bounds.width
    let spacing = numberOfItemsPerRow * interItemSpacing
    let itemWidth = (collectionViewWidth - spacing) / numberOfItemsPerRow
    
    return CGSize(width: collectionView.bounds.width, height: itemWidth)
  }
  
}
