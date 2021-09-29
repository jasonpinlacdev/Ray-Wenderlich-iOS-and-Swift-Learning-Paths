//
//  NumberCollectionViewCell.swift
//  CollectionView
//
//  Created by Jason Pinlac on 9/15/21.
//

import UIKit

class NumberCollectionViewCell: UICollectionViewCell {
  
  static let reuseId: String = String(describing: NumberCollectionViewCell.self)
  
  let textLabel: UILabel = {
    let label = UILabel()
    label.textAlignment = .center
    label.translatesAutoresizingMaskIntoConstraints = false
    return label
  }()
  
  override init(frame: CGRect) {
    super.init(frame: .zero)
    configure()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  private func configure() {
    self.contentView.addSubview(textLabel)
    NSLayoutConstraint.activate([
      textLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
      textLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
      textLabel.widthAnchor.constraint(equalTo: contentView.widthAnchor),
      textLabel.heightAnchor.constraint(equalTo: contentView.heightAnchor),
    ])
  }

}
