//
//  TLTableViewCell.swift
//  TaskList-UIKit
//
//  Created by Jason Pinlac on 6/24/20.
//  Copyright © 2020 Jason Pinlac. All rights reserved.
//

import UIKit

class TLTableViewCell: UITableViewCell {
    
    static let reuseId = "TLTableViewCell"
    let iconImageView = UIImageView(image: IconImage.rectangle)
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureLayout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureLayout() {
        iconImageView.tintColor = .systemGreen
        contentView.addSubview(iconImageView)
        iconImageView.translatesAutoresizingMaskIntoConstraints = false
        
        textLabel?.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            iconImageView.centerYAnchor.constraint(equalTo: self.contentView.centerYAnchor),
            iconImageView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 20),
            textLabel!.leadingAnchor.constraint(equalTo: iconImageView.trailingAnchor, constant: 10),
            textLabel!.centerYAnchor.constraint(equalTo: self.centerYAnchor),
        ])
    }

}
