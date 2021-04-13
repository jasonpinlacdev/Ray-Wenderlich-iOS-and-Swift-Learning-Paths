//
//  QueuedTutorialDiffableDataSource.swift
//  RayWenderlichLibrary
//
//  Created by Jason Pinlac on 4/12/21.
//  Copyright © 2021 Ray Wenderlich. All rights reserved.
//

import UIKit

enum QueuedTutorialSection {
  case main
}

class QueuedTutorialDiffableDataSource: UICollectionViewDiffableDataSource<QueuedTutorialSection, Tutorial> {

  func update(animatingDifferences: Bool) {
    var snapshot = NSDiffableDataSourceSnapshot<QueuedTutorialSection, Tutorial>()
    snapshot.appendSections([QueuedTutorialSection.main])
  
    var queuedTutorials: [Tutorial] = []
    DataRepository.shared.topics.forEach { topic in
      topic.tutorials.forEach { tutorial in
        if tutorial.isQueued { queuedTutorials.append(tutorial) }
      }
    }

    snapshot.appendItems(queuedTutorials, toSection: .main)
    self.apply(snapshot, animatingDifferences: animatingDifferences)
  }
}
