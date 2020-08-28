//
//  RMBookTableViewCell.swift
//  Read Me App Programmatically
//
//  Created by Jason Pinlac on 8/23/20.
//  Copyright © 2020 Jason Pinlac. All rights reserved.
//

import UIKit

class RMBookTableViewCell: UITableViewCell {
    
    static let reuseId = String(describing: self)
    
    let horizontalStackView: UIStackView = {
        let horizontalStackView = UIStackView()
        horizontalStackView.axis = .horizontal
        horizontalStackView.alignment = .center
        horizontalStackView.distribution = .fill
        horizontalStackView.spacing = 10.0
        horizontalStackView.translatesAutoresizingMaskIntoConstraints = false
        return horizontalStackView
    }()
    
    let verticalStackView: UIStackView = {
        let verticalStackView = UIStackView()
        verticalStackView.axis = .vertical
        verticalStackView.distribution = .fill
        verticalStackView.alignment = .fill
        return verticalStackView
    }()
    
    let titleLabel: UILabel = {
        let titleLabel = UILabel()
        titleLabel.text = "Title"
        titleLabel.font = UIFont.preferredFont(forTextStyle: .title2)
        titleLabel.numberOfLines = 1
        return titleLabel
    }()
    
    let authorLabel: UILabel = {
        let authorLabel = UILabel()
        authorLabel.text = "Author"
        authorLabel.font = UIFont.preferredFont(forTextStyle: .title3)
        authorLabel.numberOfLines = 1
        return authorLabel
    }()
    
    let reviewLabel: UILabel = {
        let reviewLabel = UILabel()
        reviewLabel.text = "Review..."
        reviewLabel.font = UIFont.preferredFont(forTextStyle: .subheadline)
        reviewLabel.numberOfLines = 1
        reviewLabel.isHidden = true
        return reviewLabel
    }()
    
    let bookThumbnailImageView: UIImageView = {
        let bookThumbnailImageView = UIImageView(image: RMLibrarySymbol.letterSquare(letter: "T").image)
        bookThumbnailImageView.preferredSymbolConfiguration = UIImage.SymbolConfiguration(weight: .light)
        bookThumbnailImageView.tintColor = .placeholderText
        bookThumbnailImageView.contentMode = .scaleAspectFill
        bookThumbnailImageView.layer.cornerRadius = 12
        bookThumbnailImageView.clipsToBounds = true
        return bookThumbnailImageView
        
    }()
    
    
    let bookmarkImageView: UIImageView = {
        let bookmarkImageView = UIImageView(image: RMLibrarySymbol.bookmarkFill.image)
        bookmarkImageView.preferredSymbolConfiguration = UIImage.SymbolConfiguration(pointSize: 28.0)
        bookmarkImageView.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        bookmarkImageView.isHidden = true
        return bookmarkImageView
    }()
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func configure() {
        verticalStackView.addArrangedSubview(titleLabel)
        verticalStackView.addArrangedSubview(authorLabel)
        verticalStackView.addArrangedSubview(reviewLabel)
        
        
        self.contentView.addSubview(horizontalStackView)
        
        horizontalStackView.addArrangedSubview(bookThumbnailImageView)
        horizontalStackView.addArrangedSubview(verticalStackView)
        horizontalStackView.addArrangedSubview(bookmarkImageView)
        
        
        NSLayoutConstraint.activate([
            bookThumbnailImageView.widthAnchor.constraint(equalTo: bookThumbnailImageView.heightAnchor),
            bookThumbnailImageView.heightAnchor.constraint(equalTo: horizontalStackView.heightAnchor, multiplier: 0.9),
            bookmarkImageView.widthAnchor.constraint(equalTo: bookmarkImageView.heightAnchor),
            
            horizontalStackView.centerYAnchor.constraint(equalTo: self.contentView.centerYAnchor),
            horizontalStackView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 20),
            horizontalStackView.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -20),
            horizontalStackView.heightAnchor.constraint(equalTo: self.contentView.heightAnchor, multiplier: 0.9)
        ])
    }
    
}
