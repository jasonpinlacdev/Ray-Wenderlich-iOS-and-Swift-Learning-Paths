//
//  TileSupplementaryView.swift
//  RayWenderlichLibrary
//
//  Created by Jason Pinlac on 10/8/20.
//  Copyright © 2020 Ray Wenderlich. All rights reserved.
//

import UIKit

final class TitleSupplementaryView: UICollectionReusableView {
    
    static let reuseIdentifier = String(describing: TitleSupplementaryView.self)
    
    let textLabel: UILabel = {
        let textLabel = UILabel()
        textLabel.translatesAutoresizingMaskIntoConstraints = false
        textLabel.font = UIFont.preferredFont(forTextStyle: .title2)
        textLabel.textColor = UIColor.black
        return textLabel
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) is not implemented")
    }
    
    private func configureLayout() {
        self.addSubview(textLabel)
        NSLayoutConstraint.activate([
            textLabel.topAnchor.constraint(equalTo: self.layoutMarginsGuide.topAnchor),
            textLabel.bottomAnchor.constraint(equalTo: self.layoutMarginsGuide.bottomAnchor),
            textLabel.leadingAnchor.constraint(equalTo: self.layoutMarginsGuide.leadingAnchor),
            textLabel.trailingAnchor.constraint(equalTo: self.layoutMarginsGuide.trailingAnchor),
        ])
    }
    
}
