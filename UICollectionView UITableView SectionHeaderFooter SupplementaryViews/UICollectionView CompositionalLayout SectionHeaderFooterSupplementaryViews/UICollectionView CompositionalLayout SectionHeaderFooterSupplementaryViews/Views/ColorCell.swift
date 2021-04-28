//
//  ColorCell.swift
//  UICollectionView CompositionalLayout SectionHeaderFooterSupplementaryViews
//
//  Created by Jason Pinlac on 3/31/21.
//

import UIKit

class ColorCell: UICollectionViewCell {
    
    static let reuseId = String(describing: ColorCell.self)
    
    @IBOutlet var label: UILabel!
    
    func set(_ color: Color) {
        label.text = color.name
        contentView.backgroundColor = color.bgColor
    }
}
