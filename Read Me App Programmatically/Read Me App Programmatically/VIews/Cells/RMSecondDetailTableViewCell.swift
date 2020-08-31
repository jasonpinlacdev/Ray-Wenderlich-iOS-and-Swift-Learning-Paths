//
//  RMSecondDetailTableViewCell.swift
//  Read Me App Programmatically
//
//  Created by Jason Pinlac on 8/29/20.
//  Copyright © 2020 Jason Pinlac. All rights reserved.
//

import UIKit

class RMSecondDetailTableViewCell: UITableViewCell {
    
    let verticalStackView: UIStackView = {
        let verticalStackView = UIStackView()
        verticalStackView.axis = .vertical
        verticalStackView.alignment = .center
        verticalStackView.distribution = .fill
        verticalStackView.translatesAutoresizingMaskIntoConstraints = false
        return verticalStackView
    }()
    
    var bookThumbnailImageView: UIImageView = {
        let bookThumbnailImageView = UIImageView(image: RMLibrarySymbol.book.image)
        bookThumbnailImageView.contentMode = .scaleAspectFill
        bookThumbnailImageView.layer.cornerRadius = 16.0
        bookThumbnailImageView.clipsToBounds = true
        return bookThumbnailImageView
    }()
    
    let updateImageButton: UIButton = {
        let updateImageButton = UIButton(type: .system)
        updateImageButton.setTitle("Update Image", for: .normal)
        updateImageButton.titleLabel?.font = UIFont.preferredFont(forTextStyle: .body)
        return updateImageButton
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureUILayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureUILayout() {
        contentView.addSubview(verticalStackView)
        
        verticalStackView.addArrangedSubview(bookThumbnailImageView)
        verticalStackView.addArrangedSubview(updateImageButton)
        
        NSLayoutConstraint.activate([
            verticalStackView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            verticalStackView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            verticalStackView.heightAnchor.constraint(equalTo: contentView.heightAnchor),
            
            bookThumbnailImageView.heightAnchor.constraint(equalTo: verticalStackView.heightAnchor, multiplier: 0.85),
            bookThumbnailImageView.widthAnchor.constraint(equalTo: bookThumbnailImageView.heightAnchor),
            
        ])
    }
}
