//
//  DataSource.swift
//  EmojiLibrary
//
//  Created by Jason Pinlac on 9/27/20.
//  Copyright © 2020 Ray Wenderlich. All rights reserved.
//

import UIKit

class EmojiCollectionViewDataSource: NSObject {
}

extension EmojiCollectionViewDataSource: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return Emoji.shared.sections.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let categoryKey = Emoji.shared.sections[section]
        return Emoji.shared.data[categoryKey]?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: EmojiCell.reuseIdentifier, for: indexPath) as? EmojiCell else { fatalError() }
        cell.emojiLabel.text = Emoji.shared.getEmoji(at: indexPath)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        guard let sectionView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: EmojiSectionHeaderCollectionReusableView.reuseIdentifier, for: indexPath) as? EmojiSectionHeaderCollectionReusableView else { fatalError("Failed to dequeue EmojiSectionheaderCollectionReusableView.") }
        sectionView.sectionLabel.text = Emoji.shared.sections[indexPath.section].rawValue
        return sectionView
        
    }

}
