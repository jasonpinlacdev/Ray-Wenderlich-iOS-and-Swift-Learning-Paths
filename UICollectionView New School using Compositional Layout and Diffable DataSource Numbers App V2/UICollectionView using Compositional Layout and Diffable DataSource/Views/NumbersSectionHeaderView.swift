//
//  NumbersSectionHeaderView.swift
//  UICollectionView using Compositional Layout and Diffable DataSource
//
//  Created by Jason Pinlac on 3/28/21.
//

import UIKit

class NumbersSectionHeaderView: UICollectionReusableView {
    static let reuseId = String(describing: NumbersSectionHeaderView.self)
    
    let label: UILabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .systemGray

        label.translatesAutoresizingMaskIntoConstraints = false
        addSubview(label)
        NSLayoutConstraint.activate([
            label.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10),
            label.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            label.widthAnchor.constraint(equalTo: self.widthAnchor),
            label.heightAnchor.constraint(equalTo: self.heightAnchor),
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
