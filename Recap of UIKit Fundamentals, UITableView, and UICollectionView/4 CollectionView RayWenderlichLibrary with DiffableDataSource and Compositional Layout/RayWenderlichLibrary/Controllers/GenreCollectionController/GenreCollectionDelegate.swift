//
//  GenreCollectionViewDelegate.swift
//  RayWenderlichLibrary
//
//  Created by Jason Pinlac on 10/5/21.
//  Copyright © 2021 Ray Wenderlich. All rights reserved.
//

import UIKit

class GenreCollectionDelegate: NSObject {
  
  weak var sourceViewController: UIViewController?
  
  init(sourceViewController: UIViewController) {
    self.sourceViewController = sourceViewController
  }
  
}


extension GenreCollectionDelegate: UICollectionViewDelegate {
  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    guard let sourceViewController = sourceViewController as? GenreCollectionController else { return }
    
    guard let tutorialDetailViewController = sourceViewController.storyboard?.instantiateViewController(identifier: TutorialDetailViewController.storyboardIdentifer, creator: { coder in
      guard let tutorial = sourceViewController.genreCollectionDiffableDataSource.itemIdentifier(for: indexPath) else { return nil }
      return TutorialDetailViewController(coder: coder, tutorial: tutorial)
    })
    else { return }
    sourceViewController.present(tutorialDetailViewController, animated: true, completion: nil)
  }
}


