//
//  DataSource.swift
//  EmojiLibrary CollectionView Old School using FlowLayout and DataSource
//
//  Created by Jason Pinlac on 3/15/21.
//

import UIKit


class EmojiCollectionDataSource: NSObject {
    
}

// MARK: UICollectionViewDataSource protocol methods - These methods allow our dataSource object to dequeue and provide the cells and data for each cell to our collectionView
extension EmojiCollectionDataSource: UICollectionViewDataSource {
   
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return Emoji.shared.sections.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let sectionCategory = Emoji.shared.sections[section]
        let emojisInSection = Emoji.shared.data[sectionCategory]!
        return emojisInSection.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: EmojiCell.reuseId, for: indexPath) as? EmojiCell else { fatalError() }
        let emoji = Emoji.shared.data[Emoji.shared.sections[indexPath.section]]![indexPath.item]
        cell.set(emoji: emoji)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        guard let emojiCollectionHeaderView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: EmojiCollectionHeaderView.reuseId, for: indexPath) as? EmojiCollectionHeaderView else { fatalError() }
        let category = Emoji.shared.sections[indexPath.section].rawValue
        emojiCollectionHeaderView.set(category: category)
        return emojiCollectionHeaderView
        
    }
    
}

// MARK: DataSource helper methods - These methods allow the dataSource object to manage the underlying data for our app
extension EmojiCollectionDataSource {
    func addEmoji(_ emoji: String, to category: Emoji.Category) {
        // get the array of emojis from the data layer
        guard var arrayOfEmojisAtCategory = Emoji.shared.data[category] else { fatalError() }
        // append the new emoji item to the array
        arrayOfEmojisAtCategory.append(emoji)
        // update the dictionary by adding back the modified array to its respective category
        Emoji.shared.data.updateValue(arrayOfEmojisAtCategory, forKey: category)
    }
    
    func deleteEmoji(at indexPath: IndexPath) {
        let category = Emoji.shared.sections[indexPath.section]
        guard var arrayOfEmojisAtCategory = Emoji.shared.data[category] else { fatalError() }
        arrayOfEmojisAtCategory.remove(at: indexPath.item)
        Emoji.shared.data.updateValue(arrayOfEmojisAtCategory, forKey: category)
    }
    
    func deleteEmojis(at indexPaths: [IndexPath]) {
        let sortedIndexPaths = indexPaths.sorted { $0 > $1 }
       sortedIndexPaths.forEach { deleteEmoji(at: $0) }
    }
}
