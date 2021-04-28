//
//  PhotoCell.swift
//  UICollectionViewCompositionalLayout Demo
//
//  Created by Jason Pinlac on 3/29/21.
//

import UIKit

class ColorCell: UICollectionViewCell {
    static let reuseId = String(describing: ColorCell.self)
    
    @IBOutlet var label: UILabel!
    
    func set(color: UIColor) {
        self.contentView.backgroundColor = color
    }
}
