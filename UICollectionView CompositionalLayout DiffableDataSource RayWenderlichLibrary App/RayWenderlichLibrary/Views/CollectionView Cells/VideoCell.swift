//
//  VideoCell.swift
//  RayWenderlichLibrary
//
//  Created by Jason Pinlac on 4/11/21.
//  Copyright © 2021 Ray Wenderlich. All rights reserved.
//

import UIKit

class VideoCell: UICollectionViewCell {
  static let reuseId = String(describing: VideoCell.self)
  @IBOutlet var titleLabel: UILabel!
}
