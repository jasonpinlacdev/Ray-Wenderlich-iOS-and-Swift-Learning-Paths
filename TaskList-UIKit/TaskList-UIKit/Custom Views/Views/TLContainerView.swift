//
//  TLContainerView.swift
//  TaskList-UIKit
//
//  Created by Jason Pinlac on 6/26/20.
//  Copyright © 2020 Jason Pinlac. All rights reserved.
//

import UIKit

class TLContainerView: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = .lightGray
        layer.cornerRadius = 10
        clipsToBounds = true
        layer.borderColor = UIColor.white.cgColor
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
