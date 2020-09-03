//
//  RMFIrstNewBookTableViewCell.swift
//  Read Me App Programmatically
//
//  Created by Jason Pinlac on 8/31/20.
//  Copyright © 2020 Jason Pinlac. All rights reserved.
//

import UIKit

class RMFirstNewBookTableViewCell: UITableViewCell {
    
    let titleLabel: UILabel = {
        let titleLabel = UILabel()
        titleLabel.text = "Title: "
        titleLabel.font = UIFont.preferredFont(forTextStyle: .headline)
        titleLabel.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        return titleLabel
    }()
    
    let titleTextField: UITextField = {
        let titleTextField = UITextField()
        titleTextField.placeholder = "Title..."
        titleTextField.font = UIFont.preferredFont(forTextStyle: .body)
        titleTextField.borderStyle = .roundedRect
        titleTextField.returnKeyType = .next
        return titleTextField
    }()
    
    let titleHorizontalStackView: UIStackView = {
        let titleHorizontalStackView = UIStackView()
        titleHorizontalStackView.axis = .horizontal
        titleHorizontalStackView.distribution = .fill
        titleHorizontalStackView.alignment = .fill
        titleHorizontalStackView.spacing = 10
        return titleHorizontalStackView
    }()
    
    
    let authorLabel: UILabel = {
        let authorLabel = UILabel()
        authorLabel.text = "Author: "
        authorLabel.font = UIFont.preferredFont(forTextStyle: .headline)
        authorLabel.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        return authorLabel
    }()
    
    let authorTextField: UITextField = {
        let authorTextField = UITextField()
        authorTextField.placeholder = "Author..."
        authorTextField.font = UIFont.preferredFont(forTextStyle: .body)
        authorTextField.borderStyle = .roundedRect
        authorTextField.returnKeyType = .done
        return authorTextField
    }()
    
    let authorHorizontalStackView: UIStackView = {
        let authorHorizontalStackView = UIStackView()
        authorHorizontalStackView.axis = .horizontal
        authorHorizontalStackView.distribution = .fill
        authorHorizontalStackView.alignment = .fill
        authorHorizontalStackView.spacing = 10
        return authorHorizontalStackView
    }()
    
    let verticalStackView: UIStackView = {
        let verticalStackView = UIStackView()
        verticalStackView.axis = .vertical
        verticalStackView.distribution = .fillEqually
        verticalStackView.alignment = .fill
        verticalStackView.translatesAutoresizingMaskIntoConstraints = false
        verticalStackView.spacing = 10
        return verticalStackView
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
        
        verticalStackView.addArrangedSubview(titleHorizontalStackView)
        verticalStackView.addArrangedSubview(authorHorizontalStackView)
        
        titleHorizontalStackView.addArrangedSubview(titleLabel)
        titleHorizontalStackView.addArrangedSubview(titleTextField)
        
        authorHorizontalStackView.addArrangedSubview(authorLabel)
        authorHorizontalStackView.addArrangedSubview(authorTextField)
        
        NSLayoutConstraint.activate([
            titleTextField.widthAnchor.constraint(equalTo: authorTextField.widthAnchor),
            
            verticalStackView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            verticalStackView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            verticalStackView.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 0.8),
            verticalStackView.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.9),
        ])
    }
    
}
