//
//  EmojiCollectionHeaderView.swift
//  EmojiLibrary CollectionView Old School using FlowLayout and DataSource
//
//  Created by Jason Pinlac on 3/16/21.
//

import UIKit

class EmojiCollectionHeaderView: UICollectionReusableView {
    
    static let reuseId = String(describing: EmojiCollectionHeaderView.self)
        
    var categoryLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        categoryLabel.translatesAutoresizingMaskIntoConstraints = false
        addSubview(categoryLabel)
        NSLayoutConstraint.activate([
            categoryLabel.widthAnchor.constraint(equalTo: widthAnchor),
            categoryLabel.heightAnchor.constraint(equalTo: heightAnchor),
            categoryLabel.centerXAnchor.constraint(equalTo: centerXAnchor, constant: 5.0),
            categoryLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
        ])
        backgroundColor = UIColor.systemRed
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func set(category: String) {
        categoryLabel.text = category
    }
}
