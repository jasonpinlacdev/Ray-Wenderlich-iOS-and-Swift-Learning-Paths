//
//  RMLibraryHeaderView.swift
//  Read Me App Programmatically
//
//  Created by Jason Pinlac on 9/1/20.
//  Copyright © 2020 Jason Pinlac. All rights reserved.
//

import UIKit

class RMLibraryHeaderView: UITableViewHeaderFooterView {
    
    let backgroundImageView: UIImageView = {
        let backgroundImageView = UIImageView(image: UIImage(named: "BookTexture"))
        backgroundImageView.contentMode = .scaleAspectFill
        backgroundImageView.clipsToBounds = true
        backgroundImageView.translatesAutoresizingMaskIntoConstraints = false
        return backgroundImageView
    }()
    
    let headerLabel: UILabel = {
        let headerLabel = UILabel()
        headerLabel.textAlignment = .center
        headerLabel.text = "Read Me!"
        headerLabel.font = UIFont(name: "American Typewriter", size: 24.0)
        headerLabel.translatesAutoresizingMaskIntoConstraints = false
        return headerLabel
    }()
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        configureUILayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureUILayout() {
        contentView.addSubview(backgroundImageView)
        contentView.addSubview(headerLabel)
        
        NSLayoutConstraint.activate([
            headerLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            headerLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            headerLabel.heightAnchor.constraint(equalTo: contentView.heightAnchor),
            headerLabel.widthAnchor.constraint(equalTo: contentView.widthAnchor),
            
            backgroundImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            backgroundImageView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            backgroundImageView.heightAnchor.constraint(equalTo: contentView.heightAnchor),
            backgroundImageView.widthAnchor.constraint(equalTo: contentView.widthAnchor),
        ])
    }
}
