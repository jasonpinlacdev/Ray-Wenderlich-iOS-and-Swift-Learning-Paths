//
//  DataSource.swift
//  EmojiLibrary
//
//  Created by Jason Pinlac on 9/27/20.
//  Copyright © 2020 Ray Wenderlich. All rights reserved.
//

import UIKit

class DataSource: NSObject {
}

extension DataSource: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return Emoji.shared.sections.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let categoryKey = Emoji.shared.sections[section]
        return Emoji.shared.data[categoryKey]?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: EmojiCell.reuseIdentifier, for: indexPath) as? EmojiCell else { fatalError() }
        let categoryKey = Emoji.shared.sections[indexPath.section]
        let emoji = Emoji.shared.data[categoryKey]?[indexPath.item]
        cell.emojiLabel.text = emoji
        return cell
    }
    
}
