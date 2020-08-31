//
//  UITextView+EXT.swift
//  Read Me App Programmatically
//
//  Created by Jason Pinlac on 8/30/20.
//  Copyright © 2020 Jason Pinlac. All rights reserved.
//

import UIKit

extension UITextView {
    func addDoneButton() {
        let toolBar = UIToolbar(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
        toolBar.sizeToFit()
        toolBar.items = [
            UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil),
            UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(self.resignFirstResponder))
        ]
        self.inputAccessoryView = toolBar
    }
}
