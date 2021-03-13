//
//  DataSource.swift
//  EmojiLibrary CollectionView Old School using FlowLayout and DataSource
//
//  Created by Jason Pinlac on 3/12/21.
//

import UIKit

class DataSource: NSObject {

}

extension DataSource: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        Emoji.shared.sections.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let category = Emoji.shared.sections[section]
        let emojisInCategory = Emoji.shared.data[category]!
        return emojisInCategory.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: EmojiCell.reuseId, for: indexPath) as? EmojiCell else { fatalError() }
        let category = Emoji.shared.sections[indexPath.section]
        let emojisInCategory = Emoji.shared.data[category]!
        let emoji = emojisInCategory[indexPath.item]
        cell.set(emoji: emoji)
        return cell
    }
}
