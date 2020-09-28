//
//  NumberCollectionViewCell.swift
//  CollectionView-CompositionalLayout-DiffableDataSource
//
//  Created by Jason Pinlac on 9/23/20.
//

import UIKit

class NumberCollectionViewCell: UICollectionViewCell {
    static var reuseId = String(describing: NumberCollectionViewCell.self)
    @IBOutlet var label: UILabel!
}
