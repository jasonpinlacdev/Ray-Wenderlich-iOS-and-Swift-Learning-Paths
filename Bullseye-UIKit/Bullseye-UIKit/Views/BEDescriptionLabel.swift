//
//  BEDescriptionLabel.swift
//  Bullseye-UIKit
//
//  Created by Jason Pinlac on 6/12/20.
//  Copyright © 2020 Jason Pinlac. All rights reserved.
//

import UIKit

class BEDescriptionLabel: UILabel {
    
    init(text: String) {
        super.init(frame: .zero)
        translatesAutoresizingMaskIntoConstraints = false
        self.text = text
        textAlignment = .center
        font = UIFont(name: "Arial Rounded MT Bold", size: 22)
        textColor = .white
        setShadow()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
