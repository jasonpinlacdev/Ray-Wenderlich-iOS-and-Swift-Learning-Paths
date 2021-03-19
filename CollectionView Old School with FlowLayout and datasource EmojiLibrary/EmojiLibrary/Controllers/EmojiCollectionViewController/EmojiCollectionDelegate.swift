//
//  Delegate.swift
//  EmojiLibrary CollectionView Old School using FlowLayout and DataSource
//
//  Created by Jason Pinlac on 3/15/21.
//

import UIKit

class EmojiCollectionDelegate: NSObject {
    
    var controller: EmojiCollectionViewController?
    
    let numberOfItemsPerRow: CGFloat
    let interItemSpacing: CGFloat
    
    init(numberOfItemsPerRow: CGFloat, interItemSpacing: CGFloat) {
        self.numberOfItemsPerRow = numberOfItemsPerRow
        self.interItemSpacing = interItemSpacing
    }
}


// MARK: - UICollectionViewDelegate - delgate protocol methods for managing user collectionView interactions
extension EmojiCollectionDelegate: UICollectionViewDelegate {
    
    //MARK: 2nd way to handle showing detail using segue + performSegue() + prepare() from didSelectItemAt
    //        func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    //            let category = Emoji.shared.sections[indexPath.section]
    //            let emoji = Emoji.shared.data[category]![indexPath.item]
    //            controller?.performSegue(withIdentifier: "ShowEmojiDetailViewController", sender: emoji )
    //        }
    
    // MARK: 4th way to handle showing detail using programmatic approach using storyboard.instantiateVC
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let category = Emoji.shared.sections[indexPath.section]
        let emoji = Emoji.shared.data[category]![indexPath.item]
        
//        guard let emojiDetailViewController = controller?.storyboard?.instantiateViewController(identifier: "EmojiDetailViewController") as? EmojiDetailViewController else { fatalError() }
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        guard let emojiDetailViewController = storyBoard.instantiateViewController(withIdentifier: "EmojiDetailViewController") as? EmojiDetailViewController else { fatalError() }
        
        emojiDetailViewController.emoji = emoji
        controller?.navigationController?.pushViewController(emojiDetailViewController, animated: true)
    }
}


// MARK: - UICollectionViewDelegateFlowLayout - delgate flow layout protocol methods for managing flow layout object specifications
extension EmojiCollectionDelegate: UICollectionViewDelegateFlowLayout {
    
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
