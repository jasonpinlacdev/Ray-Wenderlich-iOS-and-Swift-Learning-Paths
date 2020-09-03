//
//  UITextView+EXT.swift
//  ReadMe App Storyboard
//
//  Created by Jason Pinlac on 9/1/20.
//  Copyright © 2020 Jason Pinlac. All rights reserved.
//

import UIKit

extension UITextView {
    func addDoneButton() {
        let toolBar = UIToolbar()
        toolBar.sizeToFit()
        toolBar.items = [
            UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil),
            UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(self.resignFirstResponder))
        ]
        self.inputAccessoryView = toolBar
    }
}
