//
//  RMThirdDetailTableViewCell.swift
//  Read Me App Programmatically
//
//  Created by Jason Pinlac on 8/29/20.
//  Copyright © 2020 Jason Pinlac. All rights reserved.
//

import UIKit

class RMThirdDetailTableViewCell: UITableViewCell {
    
    let reviewTextView: UITextView = {
        let reviewTextView = UITextView()
        reviewTextView.text = "Review..."
        reviewTextView.backgroundColor = .secondarySystemBackground
        reviewTextView.isScrollEnabled = false
        reviewTextView.font = UIFont.preferredFont(forTextStyle: .body)
        reviewTextView.translatesAutoresizingMaskIntoConstraints = false
        reviewTextView.addDoneButton()
        return reviewTextView
    }()
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureUILayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureUILayout() {
        
        contentView.addSubview(reviewTextView)
        
        NSLayoutConstraint.activate([
            reviewTextView.heightAnchor.constraint(equalTo: contentView.heightAnchor),
            reviewTextView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            reviewTextView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            reviewTextView.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.90),
        ])
    }
    
}
