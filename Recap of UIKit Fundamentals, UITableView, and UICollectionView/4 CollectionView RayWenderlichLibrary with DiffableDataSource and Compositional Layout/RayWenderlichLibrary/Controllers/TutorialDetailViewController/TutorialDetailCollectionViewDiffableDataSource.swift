//
//  TutorialDetailCollectionViewDiffableDataSource.swift
//  RayWenderlichLibrary
//
//  Created by Jason Pinlac on 10/5/21.
//  Copyright © 2021 Ray Wenderlich. All rights reserved.
//

import UIKit

class TutorialDetailCollectionViewDiffableDataSource: UICollectionViewDiffableDataSource<Section, Video> {

  weak var sourceViewController: UIViewController?
  
  func applyInitialSnapshot() {
    guard let tutorialDetailViewController = sourceViewController as? TutorialDetailViewController else { return }
    let tutorial = tutorialDetailViewController.tutorial
    let sections = tutorial.content
    
    var initialSnapshot = NSDiffableDataSourceSnapshot<Section, Video>()
    initialSnapshot.appendSections(sections)
    sections.forEach { section in
      initialSnapshot.appendItems(section.videos, toSection: section)
    }
    
    self.apply(initialSnapshot)
  }
}
