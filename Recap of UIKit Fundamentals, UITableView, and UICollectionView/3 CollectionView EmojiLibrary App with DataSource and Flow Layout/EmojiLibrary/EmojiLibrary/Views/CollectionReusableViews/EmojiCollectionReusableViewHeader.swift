//
//  EmojiCollectionReusableViewHeader.swift
//  EmojiLibrary
//
//  Created by Jason Pinlac on 9/28/21.
//

import UIKit

class EmojiCollectionReusableViewHeader: UICollectionReusableView {
  static let reuseIdentifier = String(describing: EmojiCollectionReusableViewHeader.self)

  
  let textLabel: UILabel = {
    let label = UILabel()
    label.textAlignment = .left
    return label
  }()
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    configure()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  private func configure() {
    textLabel.translatesAutoresizingMaskIntoConstraints = false
    addSubview(textLabel)

    textLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
    textLabel.heightAnchor.constraint(equalTo: self.heightAnchor).isActive = true
    textLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10).isActive = true
    textLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
  }
  
}
