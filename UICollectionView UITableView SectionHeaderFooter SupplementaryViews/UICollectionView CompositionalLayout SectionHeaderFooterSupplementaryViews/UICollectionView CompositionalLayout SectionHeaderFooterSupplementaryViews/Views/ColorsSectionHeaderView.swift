//
//  ColorsSectionHeaderView.swift
//  UICollectionView CompositionalLayout SectionHeaderFooterSupplementaryViews
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
        addSubview(label)
        label.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            label.centerYAnchor.constraint(equalTo: centerYAnchor),
            label.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
        ])
    }
    
    func setSection(text: String) {
        label.text = text
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
