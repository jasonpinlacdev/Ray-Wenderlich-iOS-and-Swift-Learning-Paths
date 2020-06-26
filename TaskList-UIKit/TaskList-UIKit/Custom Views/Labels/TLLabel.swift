//
//  TLLabel.swift
//  TaskList-UIKit
//
//  Created by Jason Pinlac on 6/26/20.
//  Copyright © 2020 Jason Pinlac. All rights reserved.
//

import UIKit

class TLLabel: UILabel {
    
    init(text: String) {
        super.init(frame: .zero)
        translatesAutoresizingMaskIntoConstraints = false
        self.text = text
        textColor = .darkGray
        backgroundColor = .systemBlue
        //     layer.cornerRadius = 10
        textAlignment = .center
        font = UIFont.preferredFont(forTextStyle: .title1)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
