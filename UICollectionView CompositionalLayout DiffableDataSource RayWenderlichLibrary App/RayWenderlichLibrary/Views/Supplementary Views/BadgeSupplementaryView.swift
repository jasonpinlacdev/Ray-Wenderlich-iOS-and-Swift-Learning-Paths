//
//  BadgeSupplementaryView.swift
//  RayWenderlichLibrary
//
//  Created by Jason Pinlac on 4/13/21.
//  Copyright © 2021 Ray Wenderlich. All rights reserved.
//

import UIKit

class BadgeSupplementaryView: UICollectionReusableView {
  static let reuseId = String(describing: BadgeSupplementaryView.self)
  static let kind = "badge-element-kind"
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    setup()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  private func setup() {
    self.backgroundColor = UIColor(named: "rw-green")
    self.layer.cornerRadius = self.bounds.width/2
  }
  
}
