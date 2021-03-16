//
//  EmojiCollectionHeaderView.swift
//  EmojiLibrary CollectionView Old School using FlowLayout and DataSource
//
//  Created by Jason Pinlac on 3/15/21.
//

import UIKit

class EmojiCollectionHeaderView: UICollectionReusableView {
    
    static let reuseId = String(describing: EmojiCollectionHeaderView.self)
    
    let sectionLabel: UILabel = {
        let sectionLabel = UILabel()
        sectionLabel.translatesAutoresizingMaskIntoConstraints = false
        return sectionLabel
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(sectionLabel)
        NSLayoutConstraint.activate([
            sectionLabel.heightAnchor.constraint(equalTo: heightAnchor),
            sectionLabel.widthAnchor.constraint(equalTo: widthAnchor),
            sectionLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            sectionLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
        ])
    }
    
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    
    func set(emojiCategory: String) {
        sectionLabel.text = emojiCategory
    }
}
