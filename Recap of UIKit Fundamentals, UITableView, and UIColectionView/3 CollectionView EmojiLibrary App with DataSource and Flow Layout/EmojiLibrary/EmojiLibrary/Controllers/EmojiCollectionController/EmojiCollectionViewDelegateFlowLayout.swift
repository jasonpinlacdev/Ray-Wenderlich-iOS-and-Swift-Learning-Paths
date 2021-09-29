//
//  EmojiCollectionDelegateFlowLayout.swift
//  EmojiLibrary
//
//  Created by Jason Pinlac on 9/28/21.
//

import Foundation
import UIKit


class EmojiCollectionViewDelegateFlowLayout: NSObject {

  weak var sourceViewController: UIViewController?
  let numberOfItemsPerRow: CGFloat
  let interItemSpacing: CGFloat
  
  init(sourceViewController: UIViewController, numberOfItemsPerRow: CGFloat, interItemSpacing: CGFloat) {
    self.sourceViewController = sourceViewController
    self.numberOfItemsPerRow = numberOfItemsPerRow
    self.interItemSpacing = interItemSpacing
  }
  
}

// MARK: - This extension contains the methods for the UICollectionViewDelegate protocol methods -
extension EmojiCollectionViewDelegateFlowLayout {
  
  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    guard let sourceViewController = sourceViewController, !sourceViewController.isEditing else { return }
      let emojiSection = DataRepository.shared.emojiSections[indexPath.section]
      let emoji: String = DataRepository.shared.emojiData[emojiSection]![indexPath.item]
      sourceViewController.performSegue(withIdentifier: "EmojiDetailController", sender: emoji)
  }

}

// MARK: - This extension contains the methods for the DelegateFlowLayout protocol methods -
extension EmojiCollectionViewDelegateFlowLayout: UICollectionViewDelegateFlowLayout {
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    let totalSpace = collectionView.bounds.width
    let spacingForMargins = self.interItemSpacing * numberOfItemsPerRow
    let itemWidth = (totalSpace - spacingForMargins) / numberOfItemsPerRow
    return CGSize(width: itemWidth, height: itemWidth)
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
    switch section {
    case 0:
      return UIEdgeInsets(top: 0, left: 0, bottom: interItemSpacing/2.0, right: 0)
    default:
      return UIEdgeInsets(top: interItemSpacing/2.0, left: 0, bottom: interItemSpacing/2.0, right: 0)
    }
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
    return interItemSpacing
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
    return interItemSpacing
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
    return CGSize(width: collectionView.bounds.width, height: 50.0)
  }
  
}
