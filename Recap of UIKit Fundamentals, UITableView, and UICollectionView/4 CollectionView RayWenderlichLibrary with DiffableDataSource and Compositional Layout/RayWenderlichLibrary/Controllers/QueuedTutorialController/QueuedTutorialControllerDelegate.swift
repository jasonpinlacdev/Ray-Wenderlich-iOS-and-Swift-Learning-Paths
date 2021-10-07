//
//  QueuedTutorialControllerDelegate.swift
//  RayWenderlichLibrary
//
//  Created by Jason Pinlac on 10/7/21.
//  Copyright © 2021 Ray Wenderlich. All rights reserved.
//

import Foundation
import UIKit

class QueuedTutorialControllerDelegate: NSObject {
  
  weak var sourceViewController: UIViewController?
  
}

extension QueuedTutorialControllerDelegate: UICollectionViewDelegate {
  
  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    
  }
}
