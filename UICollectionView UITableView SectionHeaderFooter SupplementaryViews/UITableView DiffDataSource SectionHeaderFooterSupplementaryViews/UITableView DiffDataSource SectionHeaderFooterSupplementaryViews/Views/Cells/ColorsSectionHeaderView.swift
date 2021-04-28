//
//  ColorsSectionHeaderView.swift
//  UITableView DiffDataSource SectionHeaderFooterSupplementaryViews
//
//  Created by Jason Pinlac on 3/30/21.
//

import UIKit

class ColorsSectionHeaderView: UITableViewHeaderFooterView {
    static let reuseId = String(describing: ColorsSectionHeaderView.self)

    let label = UILabel()
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        addSubview(label)
        label.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            label.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            label.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
