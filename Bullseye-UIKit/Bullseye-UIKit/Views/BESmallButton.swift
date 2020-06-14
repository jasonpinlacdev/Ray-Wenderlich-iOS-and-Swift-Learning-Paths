//
//  BESmallButton.swift
//  Bullseye-UIKit
//
//  Created by Jason Pinlac on 6/14/20.
//  Copyright © 2020 Jason Pinlac. All rights reserved.
//

import UIKit

enum TypeOfSmallButton {
    case startOver
    case Information
}

class BESmallButton: UIButton {

    init(type: TypeOfSmallButton, target: Any?, action: Selector, forEvent: UIControl.Event) {
        
        super.init(frame: .zero)
        setBackgroundImage(UIImage(named: "SmallButton"), for: .normal)
        
        switch type {
        case .startOver:
            setImage(UIImage(named: "StartOverIcon"), for: .normal)
        case .Information:
            setImage(UIImage(named: "InfoIcon"), for: .normal)
        }
        
        translatesAutoresizingMaskIntoConstraints = false
        addTarget(target, action: action, for: forEvent)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
