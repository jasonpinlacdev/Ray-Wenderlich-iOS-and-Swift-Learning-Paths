//
//  ReadMeTableViewDelegate.swift
//  ReadMe App UITableView with DataSource
//
//  Created by Jason Pinlac on 9/3/21.
//

import UIKit

class ReadMeTableViewDelegate: NSObject {
  
}

extension ReadMeTableViewDelegate: UITableViewDelegate {
  
  func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
    if section == 0 {
      return nil
    } else {
      guard let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: LibraryHeaderView.reuseIdentifier) as? LibraryHeaderView else { return nil }
      headerView.titleLabel.text = LibrarySection.allCases[section].rawValue
      return headerView
    }
  }
  
  func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
    return section == 0 ? 0.0 : 60.0
  }

}
