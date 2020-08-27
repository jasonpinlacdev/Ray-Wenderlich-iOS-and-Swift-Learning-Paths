//
//  UIView+EXT.swift
//  ReadMe App Storyboard
//
//  Created by Jason Pinlac on 8/27/20.
//  Copyright © 2020 Jason Pinlac. All rights reserved.
//

import UIKit

extension UIView {
    func turnOnRedBorder() {
        self.layer.borderWidth = 1
        self.layer.borderColor = UIColor.red.cgColor
    }
    
    func turnOnBlueBorder() {
         self.layer.borderWidth = 1
         self.layer.borderColor = UIColor.blue.cgColor
     }
}
