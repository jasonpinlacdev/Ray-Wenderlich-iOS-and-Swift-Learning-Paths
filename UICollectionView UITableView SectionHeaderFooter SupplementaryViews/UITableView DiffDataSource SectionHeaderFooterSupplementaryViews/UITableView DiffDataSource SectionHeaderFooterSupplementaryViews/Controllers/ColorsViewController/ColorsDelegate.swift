//
//  ColorsDelegate.swift
//  UITableView DiffDataSource SectionHeaderFooterSupplementaryViews
//
//  Created by Jason Pinlac on 3/30/21.
//

import UIKit

class ColorsDelegate: NSObject {

}

extension ColorsDelegate: UITableViewDelegate {
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let colorsSectionHeaderView = tableView.dequeueReusableHeaderFooterView(withIdentifier: ColorsSectionHeaderView.reuseId) as? ColorsSectionHeaderView else { fatalError() }
        colorsSectionHeaderView.label.text = Data.ColorsSection.allCases[section].rawValue
        return colorsSectionHeaderView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
}
