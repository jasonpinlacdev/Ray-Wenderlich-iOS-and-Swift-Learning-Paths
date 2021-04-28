//
//  Color.swift
//  UICollectionView FlowLayout SectionHeaderFooterSupplementaryViews
//
//  Created by Jason Pinlac on 3/30/21.
//

import UIKit

struct Color {
    let name: String
    let bgColor: UIColor
    private let uuid: String = UUID().uuidString
}

extension Color: Hashable {
    func hash(into hasher: inout Hasher) {
        hasher.combine(name)
        hasher.combine(bgColor)
        hasher.combine(uuid)
    }
    
    static func == (lhs: Color, rhs: Color) -> Bool {
        return (lhs.name == rhs.name) && (lhs.bgColor == rhs.bgColor) && (lhs.uuid == rhs.uuid)
    }
}
