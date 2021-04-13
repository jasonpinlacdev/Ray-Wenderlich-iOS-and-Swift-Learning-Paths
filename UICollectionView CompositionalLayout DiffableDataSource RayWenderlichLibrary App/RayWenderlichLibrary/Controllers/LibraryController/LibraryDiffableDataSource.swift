//
//  LibraryDiffableDataSource.swift
//  RayWenderlichLibrary
//
//  Created by Jason Pinlac on 4/9/21.
//  Copyright © 2021 Ray Wenderlich. All rights reserved.
//

import UIKit

class LibraryDiffableDataSource: UICollectionViewDiffableDataSource<TutorialsCollection, Tutorial> {
  
  func update(animatingDifferences: Bool) {
    var snapshot = NSDiffableDataSourceSnapshot<TutorialsCollection, Tutorial>()
    snapshot.appendSections(DataRepository.shared.topics)
    DataRepository.shared.topics.forEach { snapshot.appendItems($0.tutorials, toSection: $0) }
    self.apply(snapshot, animatingDifferences: animatingDifferences)
  }
  
  // This method is used to dequeue our supplemtary section header reusable view. However, in this project we are using the diffableDataSource.supplementaryViewProvider property to give the dequeue code implementation.
  /*
  override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
    guard let librarySectionHeaderView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: LibrarySectionHeaderView.reuseId, for: indexPath) as? LibrarySectionHeaderView else { fatalError("Failed to dequeued reusable LibrarySectionHeaderView.")}
    librarySectionHeaderView.titleLabel.text = snapshot().sectionIdentifiers[indexPath.section].title
    return librarySectionHeaderView
   }
*/
  
}
