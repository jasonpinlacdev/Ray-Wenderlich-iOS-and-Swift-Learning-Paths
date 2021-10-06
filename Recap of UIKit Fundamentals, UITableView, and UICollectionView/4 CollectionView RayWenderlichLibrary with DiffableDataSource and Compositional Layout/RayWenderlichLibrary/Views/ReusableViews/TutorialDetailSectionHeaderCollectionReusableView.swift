//
//  TutorialDetailSectionHeaderCollectionReusableView.swift
//  RayWenderlichLibrary
//
//  Created by Jason Pinlac on 10/6/21.
//  Copyright © 2021 Ray Wenderlich. All rights reserved.
//

import UIKit

class TutorialDetailSectionHeaderCollectionReusableView: UICollectionReusableView {
  static var reuseIdentifier: String = String(describing: TutorialDetailSectionHeaderCollectionReusableView.self)
  
  let sectionTitleLabel: UILabel = {
    let label = UILabel()
    label.font = UIFont.preferredFont(forTextStyle: .title1)
    label.translatesAutoresizingMaskIntoConstraints = false
    return label
  }()
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    configureLayout()
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  private func configureLayout() {
    let inset: CGFloat = 10.0
    self.addSubview(sectionTitleLabel)
    
    NSLayoutConstraint.activate([
      sectionTitleLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
      sectionTitleLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor),
      sectionTitleLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: inset),
      sectionTitleLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -inset),
      sectionTitleLabel.heightAnchor.constraint(equalTo: self.heightAnchor),
    ])
  }
}

