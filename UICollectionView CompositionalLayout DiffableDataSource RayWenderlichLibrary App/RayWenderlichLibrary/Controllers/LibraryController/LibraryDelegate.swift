//
//  LibraryDelegate.swift
//  RayWenderlichLibrary
//
//  Created by Jason Pinlac on 4/11/21.
//  Copyright © 2021 Ray Wenderlich. All rights reserved.
//

import UIKit

class LibraryDelegate: NSObject {
  
  private let libraryController: LibraryController
  
  init(controller: LibraryController) {
    self.libraryController = controller
  }
}

extension LibraryDelegate: UICollectionViewDelegate {
  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    let section = libraryController.diffableDataSource.snapshot().sectionIdentifiers[indexPath.section]
    let tutorial = libraryController.diffableDataSource.snapshot().itemIdentifiers(inSection: section)[indexPath.item]
    let storyboard = UIStoryboard(name: "Main", bundle: nil)
    let tutorialDetailController = storyboard.instantiateViewController(identifier: TutorialDetailViewController.reuseId) { coder in
      return TutorialDetailViewController(coder: coder, tutorial: tutorial)
    }
    libraryController.show(tutorialDetailController, sender: nil)
  }
}
