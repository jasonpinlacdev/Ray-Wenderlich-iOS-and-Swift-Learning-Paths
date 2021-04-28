//
//  EmojiCollectionDataSource.swift
//  EmojiLibrary
//
//  Created by Jason Pinlac on 4/26/21.
//

import UIKit

class EmojiCollectionDataSource: NSObject {
  
  weak var controller: UIViewController?
  
}

// MARK: - Data Layer Methods -
extension EmojiCollectionDataSource {
  
  func add(emoji: String, to categeory: Emoji.Category) {
    guard var emojiesAtCategory = Emoji.shared.data[categeory] else { return }
    emojiesAtCategory.append(emoji)
    Emoji.shared.data.updateValue(emojiesAtCategory, forKey: categeory)
  }
  
  func deleteEmojis(at indexPaths: [IndexPath]) {
    indexPaths.sorted { $0 > $1 }.forEach {
      deleteEmoji(at: $0)
    }
  }
  
  private func deleteEmoji(at indexPath: IndexPath) {
    let categoryToDelete = Emoji.shared.sections[indexPath.section]
    var emojisAtCategoryToDelete = Emoji.shared.data[categoryToDelete]!
    emojisAtCategoryToDelete.remove(at: indexPath.item)
    Emoji.shared.data.updateValue(emojisAtCategoryToDelete, forKey: categoryToDelete)
  }
  
}

// MARK: - UICollectionViewDataSource Methods -
extension EmojiCollectionDataSource: UICollectionViewDataSource {
  func numberOfSections(in collectionView: UICollectionView) -> Int {
    let numberOfSections = Emoji.shared.sections.count
    return numberOfSections
  }
  
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    let category = Emoji.shared.sections[section]
    let emojisAtCategory = Emoji.shared.data[category]!
    return emojisAtCategory.count
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    guard let emojiCell = collectionView.dequeueReusableCell(withReuseIdentifier: EmojiCell.reuseIdentifier, for: indexPath) as? EmojiCell else { fatalError() }
    let category = Emoji.shared.sections[indexPath.section]
    let emojisAtCategory = Emoji.shared.data[category]
    let emoji = emojisAtCategory?[indexPath.row]
    emojiCell.emojiLabel.text = emoji ?? "NO EMOJI"
    emojiCell.isInEditMode = controller!.isEditing
    return emojiCell
  }
  
  func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
    guard let emojiSectionHeaderView = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: EmojiSectionHeaderView.reuseIdentifier, for: indexPath) as? EmojiSectionHeaderView else { fatalError() }
    emojiSectionHeaderView.sectionTitleLabel.text = Emoji.shared.sections[indexPath.section].rawValue
   
    return emojiSectionHeaderView
  }

  
  
}
