//
//  ColorsSectionHeaderView.swift
//  UITableView DataSource SectionHeaderFooterSupplmentaryViews
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
            label.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            label.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            label.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.9),
            label.heightAnchor.constraint(equalTo: self.heightAnchor),
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
