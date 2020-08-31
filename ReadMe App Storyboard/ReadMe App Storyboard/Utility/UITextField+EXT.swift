//
//  UITextField+EXT.swift
//  Read Me App Programmatically
//
//  Created by Jason Pinlac on 8/31/20.
//  Copyright © 2020 Jason Pinlac. All rights reserved.
//

import UIKit

extension UITextField {
    func addDoneButton() {
        let toolbar = UIToolbar(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
        toolbar.sizeToFit()
        toolbar.items = [
            UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil),
            UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(resignFirstResponder))
        ]
        self.inputAccessoryView = toolbar
    }
}
