//
//  TLButton.swift
//  TaskList-UIKit
//
//  Created by Jason Pinlac on 6/26/20.
//  Copyright © 2020 Jason Pinlac. All rights reserved.
//

import UIKit

class TLButton: UIButton {

    override init(frame: CGRect) {
        super.init(frame: frame)
       translatesAutoresizingMaskIntoConstraints = false
       titleLabel?.font = UIFont.preferredFont(forTextStyle: .headline)
       layer.cornerRadius = 5
    }
    
    convenience init(title: String, titleColor: UIColor, buttonColor: UIColor) {
        self.init(frame: .zero)
        setTitle(title, for: .normal)
        setTitleColor(titleColor, for: .normal)
        backgroundColor = buttonColor
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
