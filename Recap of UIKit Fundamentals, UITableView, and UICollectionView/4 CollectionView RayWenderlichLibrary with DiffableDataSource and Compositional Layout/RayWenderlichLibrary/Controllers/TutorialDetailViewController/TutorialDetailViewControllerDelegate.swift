//
//  TutorialDetailViewControllerDelegate.swift
//  RayWenderlichLibrary
//
//  Created by Jason Pinlac on 10/6/21.
//  Copyright © 2021 Ray Wenderlich. All rights reserved.
//

import UIKit

class TutorialDetailCollectionView: NSObject {
  
}


extension TutorialDetailCollectionView: UICollectionViewDelegate {
  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    print("Video Selected")
  }
}
