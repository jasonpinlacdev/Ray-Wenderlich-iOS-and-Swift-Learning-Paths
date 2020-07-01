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
    let checkMarkImageView = UIImageView(image: IconImage.checkMark)
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureLayout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureLayout() {
        addSubview(checkMarkImageView)
        checkMarkImageView.translatesAutoresizingMaskIntoConstraints = false
        
        textLabel?.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            checkMarkImageView.centerYAnchor.constraint(equalTo: textLabel!.centerYAnchor),
            checkMarkImageView.leadingAnchor.constraint(equalTo: self.layoutMarginsGuide.leadingAnchor),
            textLabel!.leadingAnchor.constraint(equalTo: checkMarkImageView.trailingAnchor, constant: 20),
            textLabel!.centerYAnchor.constraint(equalTo: self.centerYAnchor),
        ])
    }

}
