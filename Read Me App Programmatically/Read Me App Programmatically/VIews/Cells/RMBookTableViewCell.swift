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
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func configure() {
        imageView?.image = UIImage(systemName: "book.fill")
        imageView?.preferredSymbolConfiguration = UIImage.SymbolConfiguration(font: UIFont.preferredFont(forTextStyle: .largeTitle))
        textLabel?.font = UIFont.preferredFont(forTextStyle: .title2)
    }
    
}
