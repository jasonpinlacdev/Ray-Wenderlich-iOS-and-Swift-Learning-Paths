//
//  BadgeSupplementaryView.swift
//  RayWenderlichLibrary
//
//  Created by Jason Pinlac on 5/14/21.
//  Copyright © 2021 Ray Wenderlich. All rights reserved.
//

import UIKit

class BadgeSupplementaryView: UICollectionReusableView {
  static let reuseId = String(describing: BadgeSupplementaryView.self)
  static let kind = "badge-element-kind"
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    configure()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  private func configure() {
    backgroundColor = UIColor(named: "rw-green")
    self.layer.cornerRadius = self.bounds.size.width/2
    self.clipsToBounds = true
  }
  
  
  
  
}
