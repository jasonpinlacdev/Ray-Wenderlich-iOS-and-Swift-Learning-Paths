//
//  GenreCollectionDiffableDataSource.swift
//  RayWenderlichLibrary
//
//  Created by Jason Pinlac on 10/3/21.
//  Copyright © 2021 Ray Wenderlich. All rights reserved.
//

import UIKit

class GenreCollectionDiffableDataSource: UICollectionViewDiffableDataSource<Genre, Tutorial> {
  
  func applyInitialSnapshot() {
    var initialSnapshot = NSDiffableDataSourceSnapshot<Genre, Tutorial>()
    let sections = DataRepository.shared.genreCollection
    initialSnapshot.appendSections(sections)
    sections.forEach { genre in
      let tutorials = genre.tutorials
      initialSnapshot.appendItems(tutorials, toSection: genre)
    }
    self.apply(initialSnapshot, animatingDifferences: false)
  }
 
//  override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
//    guard let genreSectionTitleCollectionReusableView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: GenreSectionTitleCollectionReusableView.reuseIdentifier, for: indexPath) as? GenreSectionTitleCollectionReusableView else { fatalError("Failed to dequeue GenreSectionTitleCollectionReusableView") }
//    genreSectionTitleCollectionReusableView.sectionTitleLabel.text = self.sectionIdentifier(for: indexPath.section)?.title
//    return genreSectionTitleCollectionReusableView
//  }
}


