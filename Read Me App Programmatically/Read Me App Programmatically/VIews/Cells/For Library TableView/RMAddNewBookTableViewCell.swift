//
//  RMAddNewBookTableViewCell.swift
//  Read Me App Programmatically
//
//  Created by Jason Pinlac on 8/27/20.
//  Copyright © 2020 Jason Pinlac. All rights reserved.
//

import UIKit

class RMAddNewBookTableViewCell: UITableViewCell {
    
    static let reuseId = String(describing: RMAddNewBookTableViewCell.self)
    
    let addNewBookImageView: UIImageView = {
        let addNewBookImageView = UIImageView(image: UIImage(systemName: "book.circle"))
        addNewBookImageView.preferredSymbolConfiguration = UIImage.SymbolConfiguration(weight: .light)
        addNewBookImageView.contentMode = .scaleAspectFill
        return addNewBookImageView
    }()
    
    let addNewBookLabel: UILabel = {
       let addNewBookLabel = UILabel()
        addNewBookLabel.text = "Add New Book"
        addNewBookLabel.font = UIFont.preferredFont(forTextStyle: .title2)
        return addNewBookLabel
    }()
    
    let horizontalStackView: UIStackView = {
        let horizontalStackView = UIStackView()
        horizontalStackView.axis = .horizontal
        horizontalStackView.alignment = .center
        horizontalStackView.distribution = .fill
        horizontalStackView.spacing = 10.0
        horizontalStackView.translatesAutoresizingMaskIntoConstraints = false
        return horizontalStackView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureUILayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureUILayout() {
        self.contentView.addSubview(horizontalStackView)
        
        horizontalStackView.addArrangedSubview(addNewBookImageView)
        horizontalStackView.addArrangedSubview(addNewBookLabel)
        
        NSLayoutConstraint.activate([
            horizontalStackView.heightAnchor.constraint(equalTo: self.contentView.heightAnchor, multiplier: 0.9),
            horizontalStackView.centerYAnchor.constraint(equalTo: self.contentView.centerYAnchor),
            horizontalStackView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 20),
            horizontalStackView.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -20),
            
            addNewBookImageView.heightAnchor.constraint(equalTo: horizontalStackView.heightAnchor, multiplier: 0.9),
            addNewBookImageView.widthAnchor.constraint(equalTo: addNewBookImageView.heightAnchor),
        ])
    }
    
    
    
}
