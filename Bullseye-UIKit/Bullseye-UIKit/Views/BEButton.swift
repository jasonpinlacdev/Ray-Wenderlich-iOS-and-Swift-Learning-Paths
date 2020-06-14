//
//  BEButton.swift
//  Bullseye-UIKit
//
//  Created by Jason Pinlac on 6/14/20.
//  Copyright © 2020 Jason Pinlac. All rights reserved.
//

import UIKit

class BEButton: UIButton {
    
    init(title: String? = nil, target: Any?, action: Selector, forEvent: UIControl.Event) {
        super.init(frame: .zero)
        
        setBackgroundImage(UIImage(named: "Button-Normal"), for: .normal)
        setBackgroundImage(UIImage(named: "Button-Highlighted"), for: .highlighted)
        
        translatesAutoresizingMaskIntoConstraints = false
        setTitle(title, for: .normal)
        setTitleColor(.systemGray4, for: .normal)
        titleLabel?.font = UIFont.systemFont(ofSize: 24, weight: .semibold)
        addTarget(target, action: action, for: forEvent)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
