//
//  EmojiSectionHeaderView.swift
//  EmojiLibrary
//
//  Created by Jason Pinlac on 4/26/21.
//

import UIKit

class EmojiSectionHeaderView: UICollectionReusableView {
  static let reuseIdentifier = String(describing: EmojiSectionHeaderView.self)
  
  let sectionTitleLabel = UILabel()
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    setup()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  func setup() {
    addSubview(sectionTitleLabel)
    sectionTitleLabel.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      sectionTitleLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10),
      sectionTitleLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10),
      sectionTitleLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor)
    ])
  }
}
