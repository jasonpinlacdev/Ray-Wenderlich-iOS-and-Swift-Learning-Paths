//
//  LibrarySectionHeaderView.swift
//  RayWenderlichLibrary
//
//  Created by Jason Pinlac on 4/9/21.
//  Copyright © 2021 Ray Wenderlich. All rights reserved.
//

import UIKit

class LibrarySectionHeaderView: UICollectionReusableView {
  static let reuseId = String(describing: LibrarySectionHeaderView.self)
  
  let titleLabel = UILabel()
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    addSubview(titleLabel)
    titleLabel.translatesAutoresizingMaskIntoConstraints = false
    titleLabel.font = UIFont.preferredFont(forTextStyle: .title2)
    NSLayoutConstraint.activate([
      titleLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 10.0),
      titleLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10.0),
      titleLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10.0),
      titleLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -10.0),
    ])
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
}
