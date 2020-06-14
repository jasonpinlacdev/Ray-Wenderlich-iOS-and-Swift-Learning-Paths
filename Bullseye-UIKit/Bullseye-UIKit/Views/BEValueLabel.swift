//
//  BEValueLabel.swift
//  Bullseye-UIKit
//
//  Created by Jason Pinlac on 6/12/20.
//  Copyright © 2020 Jason Pinlac. All rights reserved.
//

import UIKit

class BEValueLabel: UILabel {

    init(value: String, fontSize: CGFloat = 24.0, textColor: UIColor = UIColor.systemYellow) {
        super.init(frame: .zero)
        translatesAutoresizingMaskIntoConstraints = false
        self.text = value
        textAlignment = .center
        font = UIFont.systemFont(ofSize: fontSize, weight: .semibold)
        self.textColor = textColor
        setShadow()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
