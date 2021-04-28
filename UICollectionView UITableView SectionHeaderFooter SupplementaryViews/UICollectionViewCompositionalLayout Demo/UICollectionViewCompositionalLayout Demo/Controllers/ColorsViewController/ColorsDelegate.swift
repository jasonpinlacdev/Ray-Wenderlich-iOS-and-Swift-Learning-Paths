//
//  PhotosDelegate.swift
//  UICollectionViewCompositionalLayout Demo
//
//  Created by Jason Pinlac on 3/29/21.
//

import UIKit

class ColorsDelegate: NSObject {
    
}

extension ColorsDelegate: UICollectionViewDelegate {
    
}

extension ColorsDelegate: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let numberOfItemsPerRow: CGFloat = 3.0
        let interItemSpacing: CGFloat = 5.0
        let totalWidth = collectionView.bounds.width
        let availableWidth = totalWidth - (numberOfItemsPerRow * interItemSpacing)
        let itemDimension = floor(availableWidth/numberOfItemsPerRow)
        return CGSize(width: itemDimension, height: itemDimension)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        5.0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        5.0
    }

}
