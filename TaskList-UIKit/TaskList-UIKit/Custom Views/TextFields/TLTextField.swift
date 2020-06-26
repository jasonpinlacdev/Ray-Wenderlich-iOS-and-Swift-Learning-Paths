//
//  TLTextField.swift
//  TaskList-UIKit
//
//  Created by Jason Pinlac on 6/26/20.
//  Copyright © 2020 Jason Pinlac. All rights reserved.
//

import UIKit

class TLTextField: UITextField {
    override init(frame: CGRect) {
        super.init(frame: frame)
        translatesAutoresizingMaskIntoConstraints = false
        placeholder = "Enter a task description..."
        backgroundColor = .darkGray
        layer.cornerRadius = 10
        //      layer.borderWidth = 1
        //      layer.borderColor = UIColor.white.cgColor
        textColor = .lightGray
        font = UIFont.systemFont(ofSize: 20)
        leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 10))
        leftViewMode = .always
        rightView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 10))
        rightViewMode = .always
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
