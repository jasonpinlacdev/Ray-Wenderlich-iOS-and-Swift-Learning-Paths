//
//  EmojiCollectionViewDelegate.swift
//  EmojiLibrary
//
//  Created by Jason Pinlac on 9/27/20.
//  Copyright © 2020 Ray Wenderlich. All rights reserved.
//

import UIKit

class EmojiCollectionViewDelegate: NSObject {
    
    let numberOfItemsPerRow: CGFloat
    let minimumInterItemSpacing: CGFloat
    
    init(numberOfItemsPerRow: CGFloat, minimumInterItemSpacing: CGFloat) {
        self.numberOfItemsPerRow = numberOfItemsPerRow
        self.minimumInterItemSpacing = minimumInterItemSpacing
    }
    
}

extension EmojiCollectionViewDelegate: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let maxScreenWidth = UIScreen.main.bounds.width
        let totalSpacing = minimumInterItemSpacing * numberOfItemsPerRow
        let itemWidth = (maxScreenWidth - totalSpacing) / numberOfItemsPerRow
        return CGSize(width: itemWidth, height: itemWidth)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return minimumInterItemSpacing
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        if section == 0 {
            return UIEdgeInsets(top: 0, left: 0, bottom: minimumInterItemSpacing/2, right: 0)
        }
        return UIEdgeInsets(top: minimumInterItemSpacing/2, left: 0, bottom: minimumInterItemSpacing/2, right: 0)
    }
    
}
