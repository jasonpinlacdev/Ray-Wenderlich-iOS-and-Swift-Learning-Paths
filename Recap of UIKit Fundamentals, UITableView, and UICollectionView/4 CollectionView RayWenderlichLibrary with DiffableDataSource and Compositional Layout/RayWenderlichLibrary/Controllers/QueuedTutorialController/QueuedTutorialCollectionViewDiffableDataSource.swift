//
//  QueuedTutorialCollectionViewDiffableDataSource.swift
//  RayWenderlichLibrary
//
//  Created by Jason Pinlac on 10/7/21.
//  Copyright © 2021 Ray Wenderlich. All rights reserved.
//

import UIKit

enum QueuedTutorialSection {
  case main
}

class QueuedTutorialCollectionViewDiffableDataSource: UICollectionViewDiffableDataSource<QueuedTutorialSection, Tutorial> {

  func updateSnapshot() {
    var snapshot = NSDiffableDataSourceSnapshot<QueuedTutorialSection, Tutorial>()
    snapshot.appendSections([.main])
    snapshot.appendItems(DataRepository.shared.getQueuedTutorials(), toSection: .main)
    self.apply(snapshot)
  }
}
