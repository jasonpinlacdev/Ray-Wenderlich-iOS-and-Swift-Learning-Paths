//
//  FirstNameTableViewCell.swift
//  Static UITableView Programmatically
//
//  Created by Jason Pinlac on 8/29/20.
//  Copyright © 2020 Jason Pinlac. All rights reserved.
//

import UIKit

class FirstNameTableViewCell: UITableViewCell {
    
    lazy var firstNameTextField: UITextField = {
        let firstNameTextField = UITextField(frame: self.contentView.bounds.insetBy(dx: 20, dy: 0))
        firstNameTextField.placeholder = "First Name"
        firstNameTextField.returnKeyType = .done
        return firstNameTextField
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.backgroundColor = .secondarySystemBackground
        
        self.addSubview(firstNameTextField)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
}
