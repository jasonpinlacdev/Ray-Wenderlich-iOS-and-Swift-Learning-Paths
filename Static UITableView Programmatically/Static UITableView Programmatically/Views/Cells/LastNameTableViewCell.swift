//
//  LastNameTableViewCell.swift
//  Static UITableView Programmatically
//
//  Created by Jason Pinlac on 8/29/20.
//  Copyright © 2020 Jason Pinlac. All rights reserved.
//

import UIKit

class LastNameTableViewCell: UITableViewCell {
    
    lazy var lastNameTextField: UITextField = {
        let lastNameTextField = UITextField(frame: self.contentView.bounds.insetBy(dx: 20, dy: 0))
        lastNameTextField.placeholder = "Last Name"
        lastNameTextField.returnKeyType = .done
        return lastNameTextField
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.backgroundColor = .secondarySystemBackground
        self.addSubview(lastNameTextField)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
