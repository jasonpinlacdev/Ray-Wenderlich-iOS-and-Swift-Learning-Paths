//
//  ColorsSectionHeaderView.swift
//  UICollectionView FlowLayout SectionHeaderFooterSupplementaryViews
//
//  Created by Jason Pinlac on 3/31/21.
//

import UIKit

class ColorsSectionHeaderView: UICollectionReusableView {
    static let reuseId = String(describing: ColorsSectionHeaderView.self)
    
    let label = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .systemGray
        self.addSubview(label)
        label.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            label.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            label.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10),
            label.trailingAnchor.constraint(equalTo: self.trailingAnchor),
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
