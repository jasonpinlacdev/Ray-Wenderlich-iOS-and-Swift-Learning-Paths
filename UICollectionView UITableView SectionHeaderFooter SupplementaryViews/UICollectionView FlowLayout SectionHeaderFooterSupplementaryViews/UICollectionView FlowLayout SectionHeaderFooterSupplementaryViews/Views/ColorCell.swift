//
//  ColorCell.swift
//  UICollectionView FlowLayout SectionHeaderFooterSupplementaryViews
//
//  Created by Jason Pinlac on 3/30/21.
//

import UIKit

class ColorCell: UICollectionViewCell {
    static let reuseId = String(describing: ColorCell.self)
    
    
    @IBOutlet var label: UILabel!
    
    func set(color: Color) {
        label.text = color.name
        self.contentView.backgroundColor = color.bgColor
    }
    

}
