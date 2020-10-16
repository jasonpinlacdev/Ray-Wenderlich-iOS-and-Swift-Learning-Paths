//
//  BadgeSupplementaryView.swift
//  RayWenderlichLibrary
//
//  Created by Jason Pinlac on 10/15/20.
//  Copyright © 2020 Ray Wenderlich. All rights reserved.
//

import UIKit

final class BadgeSupplementaryView: UICollectionReusableView {
    static var reuseIdentifier = String(describing: BadgeSupplementaryView.self)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        self.backgroundColor = UIColor.RWGreen
        let radius = bounds.width/2.0
        self.layer.cornerRadius = radius
    }
}
