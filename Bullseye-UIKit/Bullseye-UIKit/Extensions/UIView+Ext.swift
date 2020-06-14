//
//  UIView+Ext.swift
//  Bullseye-UIKit
//
//  Created by Jason Pinlac on 6/12/20.
//  Copyright © 2020 Jason Pinlac. All rights reserved.
//

import UIKit


extension UIView {
    func setShadow() {
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOffset = CGSize(width: 0, height: 3)
        self.layer.shadowRadius = 0.0
        self.layer.shadowOpacity = 1.0
        self.layer.masksToBounds = false
    }
}
