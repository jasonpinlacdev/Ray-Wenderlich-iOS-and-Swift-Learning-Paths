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
        setTitleColor(UIColor(red: 96.0/255.0, green: 30.0/255.0, blue: 0, alpha: 1.0), for: .normal)
        setTitleShadowColor(UIColor(red: 1, green: 1, blue: 1, alpha: 0.5), for: .normal)
        titleLabel?.shadowOffset = CGSize(width: 0, height: 2)
        reversesTitleShadowWhenHighlighted = true
        titleLabel?.font = UIFont(name: "Arial Rounded MT Bold", size: 24)
        addTarget(target, action: action, for: forEvent)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
