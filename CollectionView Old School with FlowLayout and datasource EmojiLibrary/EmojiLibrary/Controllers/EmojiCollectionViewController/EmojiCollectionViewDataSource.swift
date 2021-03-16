//
//  DataSource.swift
//  EmojiLibrary CollectionView Old School using FlowLayout and DataSource
//
//  Created by Jason Pinlac on 3/15/21.
//

import UIKit


class EmojiCollectionViewDataSource: NSObject {
    
}

extension EmojiCollectionViewDataSource: UICollectionViewDataSource {
   
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
        guard let sectionHeaderView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: EmojiCollectionHeaderView.reuseId, for: indexPath) as? EmojiCollectionHeaderView else { fatalError() }
        let category = Emoji.shared.sections[indexPath.section]
        sectionHeaderView.set(emojiCategory: category.rawValue)
        return sectionHeaderView
    }
    
}

