//
//  Delegate.swift
//  EmojiLibrary CollectionView Old School using FlowLayout and DataSource
//
//  Created by Jason Pinlac on 3/15/21.
//

import UIKit

class EmojiCollectionViewDelegate: NSObject {
    
    var controller: EmojiCollectionViewController?
    
    let numberOfItemsPerRow: CGFloat
    let interItemSpacing: CGFloat
    
    init(numberOfItemsPerRow: CGFloat, interItemSpacing: CGFloat) {
        self.numberOfItemsPerRow = numberOfItemsPerRow
        self.interItemSpacing = interItemSpacing
    }
}

extension EmojiCollectionViewDelegate: UICollectionViewDelegate {
//    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        if let controller = controller {
//            controller.performSegue(withIdentifier: "ShowEmojiDetailViewController", sender: nil)
//        }
//    }
}

extension EmojiCollectionViewDelegate: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let maxWidth = UIScreen.main.bounds.width
        let totalSpacing = self.interItemSpacing * self.numberOfItemsPerRow
        let itemWidth = (maxWidth - totalSpacing) / self.numberOfItemsPerRow
        return CGSize(width: itemWidth, height: itemWidth)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return interItemSpacing
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return interItemSpacing
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        if section == 0 {
            return UIEdgeInsets(top: 0, left: 0, bottom: interItemSpacing/2, right: 0)
        } else {
            return UIEdgeInsets(top: interItemSpacing/2, left: 0, bottom: interItemSpacing/2, right: 0)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: UIScreen.main.bounds.width, height: 50.0)
    }
    
    
}
