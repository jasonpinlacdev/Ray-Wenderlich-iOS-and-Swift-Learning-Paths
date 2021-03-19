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
        cell.contentView.backgroundColor = UIColor(red: CGFloat.random(in: 0.0...1.0), green: CGFloat.random(in: 0.0...1.0), blue: CGFloat.random(in: 0.0...1.0), alpha: 1.0)
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
        guard var emojisAtCategory = Emoji.shared.data[category] else { return }
        emojisAtCategory.append(emoji)
        Emoji.shared.data.updateValue(emojisAtCategory, forKey: category)
    }
}

