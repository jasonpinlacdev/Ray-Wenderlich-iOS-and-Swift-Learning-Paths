//
//  Delegate.swift
//  EmojiLibrary CollectionView Old School using FlowLayout and DataSource
//
//  Created by Jason Pinlac on 3/15/21.
//

import UIKit

class EmojiCollectionViewDelegate: NSObject {
    
    let numberOfItemsPerRow: CGFloat
    let interItemSpacing: CGFloat
    
    init(numberOfItemsPerRow: CGFloat, interItemSpacing: CGFloat) {
        self.numberOfItemsPerRow = numberOfItemsPerRow
        self.interItemSpacing = interItemSpacing
    }
}

extension EmojiCollectionViewDelegate: UICollectionViewDelegate {
    
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
        return UIEdgeInsets(top: interItemSpacing, left: 0, bottom: interItemSpacing, right: 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: collectionView.bounds.width, height: 50.0)
    }
    
}
