//
//  NumberCell.swift
//  CollectionView
//
//  Created by Jason Pinlac on 3/2/21.
//

import UIKit

class NumberCell: UICollectionViewCell {
    
    static let reuseId: String = String(describing: NumberCell.self)
    
    @IBOutlet var numberLabel: UILabel!

    func set(text: String) {
        numberLabel.text = text
        contentView.backgroundColor = UIColor(red: CGFloat.random(in: 0.0...1.0), green: CGFloat.random(in: 0.0...1.0), blue: CGFloat.random(in: 0.0...1.0), alpha: 1.0)
    }
    
}
