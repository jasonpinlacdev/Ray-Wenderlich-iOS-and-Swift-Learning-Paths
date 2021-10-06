//
//  EmojiCollectionDataSource.swift
//  EmojiLibrary
//
//  Created by Jason Pinlac on 9/28/21.
//

import Foundation
import UIKit

class EmojiCollectionViewDataSource: NSObject {
  
  weak var sourceViewController: UIViewController?
  
  init(sourceViewController: UIViewController) {
    self.sourceViewController = sourceViewController
  }
}

extension EmojiCollectionViewDataSource: UICollectionViewDataSource {
  
  func numberOfSections(in collectionView: UICollectionView) -> Int {
    return DataRepository.shared.emojiSections.count
  }
  
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    let section = DataRepository.shared.emojiSections[section]
    let sectionEmojis = DataRepository.shared.emojiData[section]!
    return sectionEmojis.count
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    guard let emojiCell = collectionView.dequeueReusableCell(withReuseIdentifier: EmojiCell.reuseIdentifier, for: indexPath) as? EmojiCell else { fatalError("Failed to dequeue an EmojiCell.") }
    let emojiCategorySection = DataRepository.shared.emojiSections[indexPath.section]
    emojiCell.emojiLabel.text = DataRepository.shared.emojiData[emojiCategorySection]![indexPath.item]
    emojiCell.sourceViewController = self.sourceViewController
    return emojiCell
  }
  
  
  func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
    guard let emojiCollectionReusableViewHeader = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: EmojiCollectionReusableViewHeader.reuseIdentifier, for: indexPath) as? EmojiCollectionReusableViewHeader else { fatalError("Failed to dequeue an EmojiCollectionReusableViewHeader") }
    emojiCollectionReusableViewHeader.textLabel.text = DataRepository.shared.emojiSections[indexPath.section].rawValue
    return emojiCollectionReusableViewHeader
  }
  
}

// MARK: - This extension contains the methods that give the dataSource the responsibility of modifying the data layer/repository. Keep in mind that the data layer needs to be in sync with the collectionView UI.
extension EmojiCollectionViewDataSource {
  
  func addEmoji(_ emoji: String, emojiSectionCategory: DataRepository.EmojiSectionCategory) {
    var emojisAtCategory = DataRepository.shared.emojiData[emojiSectionCategory]!
    emojisAtCategory.append(emoji)
    DataRepository.shared.emojiData.updateValue(emojisAtCategory, forKey: emojiSectionCategory)
  }
  
  
  func deleteEmojis(for indexPaths: [IndexPath]) {
    indexPaths.forEach { deleteEmoji(at: $0) }
  }
  
  private func deleteEmoji(at indexPath: IndexPath) {
    let section = indexPath.section
    let emojiSection = DataRepository.shared.emojiSections[section]
    var emojis = DataRepository.shared.emojiData[emojiSection]!
    emojis.remove(at: indexPath.item)
    DataRepository.shared.emojiData.updateValue(emojis, forKey: emojiSection)
  }
  
}
