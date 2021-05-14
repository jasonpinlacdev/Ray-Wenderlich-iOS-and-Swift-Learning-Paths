//
//  TitleSupplementaryView.swift
//  RayWenderlichLibrary
//
//  Created by Jason Pinlac on 5/12/21.
//  Copyright © 2021 Ray Wenderlich. All rights reserved.
//

import UIKit

class TitleSupplementaryView: UICollectionReusableView {
  static let reuseId = String(describing: TitleSupplementaryView.self)
  
  let titleLabel: UILabel = {
    let label = UILabel()
    label.translatesAutoresizingMaskIntoConstraints = false
    return label
  }()
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    configure()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  func configure() {
    titleLabel.font = UIFont(name: "American Typewriter", size: 20)
    self.addSubview(titleLabel)
    NSLayoutConstraint.activate([
      titleLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor),
      titleLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10),
      titleLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10),
    ])
  }
}
