//
//  RMFirstDetailTableViewCell.swift
//  Read Me App Programmatically
//
//  Created by Jason Pinlac on 8/29/20.
//  Copyright © 2020 Jason Pinlac. All rights reserved.
//

import UIKit

class RMFirstDetailTableViewCell: UITableViewCell {
    
    let bookmarkButton: UIButton = {
        let bookmarkButton = UIButton(type: .custom)
        bookmarkButton.setImage(RMLibrarySymbol.bookmarkFill.image, for: .normal)
        bookmarkButton.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        bookmarkButton.setPreferredSymbolConfiguration(UIImage.SymbolConfiguration(pointSize: 48), forImageIn: .normal)
        bookmarkButton.contentMode = .scaleAspectFill
        return bookmarkButton
    }()
    
    let titleLabel: UILabel = {
        let titleLabel = UILabel()
        titleLabel.font = UIFont.preferredFont(forTextStyle: .title1)
        titleLabel.numberOfLines = 0
        titleLabel.text = "Title"
        return titleLabel
    }()
    
    let authorLabel: UILabel = {
        let authorLabel = UILabel()
        authorLabel.font = UIFont.preferredFont(forTextStyle: .title2)
        authorLabel.text = "Author"
        authorLabel.textColor = .secondaryLabel
        return authorLabel
    }()
    
    let verticalStack: UIStackView = {
        let verticalStack = UIStackView()
        verticalStack.axis = .vertical
        verticalStack.alignment = .fill
        verticalStack.distribution = .fill
        return verticalStack
    }()
    
    let horizontalStack: UIStackView = {
        let horizontalStack = UIStackView()
        horizontalStack.axis = .horizontal
        horizontalStack.alignment = .center
        horizontalStack.distribution = .fill
        horizontalStack.spacing = 10.0
        horizontalStack.translatesAutoresizingMaskIntoConstraints = false
        return horizontalStack
    }()
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureUILayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureUILayout() {
        contentView.addSubview(horizontalStack)
        
        horizontalStack.addArrangedSubview(bookmarkButton)
        horizontalStack.addArrangedSubview(verticalStack)
        
        verticalStack.addArrangedSubview(titleLabel)
        verticalStack.addArrangedSubview(authorLabel)

        NSLayoutConstraint.activate([
            horizontalStack.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 0.9),
            horizontalStack.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            horizontalStack.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            horizontalStack.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.9),
        ])
    }
    
}
