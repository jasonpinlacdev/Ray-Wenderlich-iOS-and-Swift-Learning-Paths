//
//  BESlider.swift
//  Bullseye-UIKit
//
//  Created by Jason Pinlac on 6/12/20.
//  Copyright © 2020 Jason Pinlac. All rights reserved.
//

import UIKit

class BESlider: UISlider {
    
    init() {
        super.init(frame: .zero)
        minimumTrackTintColor = .systemGreen
        maximumTrackTintColor = .white
//        setMinimumTrackImage(UIImage(named: "SliderTrackLeft"), for: .normal)
//        setMaximumTrackImage(UIImage(named: "SliderTrackRight"), for: .normal)
//
        setThumbImage(UIImage(named: "SliderThumb-Normal"), for: .normal)
        setThumbImage(UIImage(named: "SliderThumb-Highlighted"), for: .highlighted)
        
        maximumValue = 100
        minimumValue = 1
        setValue(50.0, animated: false)
        translatesAutoresizingMaskIntoConstraints = false
        
        setShadow()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func trackRect(forBounds bounds: CGRect) -> CGRect {
        var newRect = super.trackRect(forBounds: bounds)
        newRect.size.height = 7.5
        return newRect
    }
}
