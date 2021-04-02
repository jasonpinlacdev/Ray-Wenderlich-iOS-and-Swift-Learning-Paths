//
//  NumberCell.swift
//  UICollectionView using Compositional Layout and Diffable DataSource
//
//  Created by Jason Pinlac on 3/28/21.
//

import UIKit

class NumberCell: UICollectionViewCell {
    
    static let reuseId = String(describing: NumberCell.self)

    @IBOutlet var label: UILabel!
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.contentView.backgroundColor = .systemRed
    }
    
    func set(number: Int) {
        label.text = String(number)
    }
}
