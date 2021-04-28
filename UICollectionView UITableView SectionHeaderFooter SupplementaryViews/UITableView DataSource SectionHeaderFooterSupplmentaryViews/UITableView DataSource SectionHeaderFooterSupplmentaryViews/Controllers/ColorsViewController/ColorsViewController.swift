//
//  ColorsViewController.swift
//  UITableView DataSource SectionHeaderFooterSupplmentaryViews
//
//  Created by Jason Pinlac on 3/30/21.
//

import UIKit

class ColorsViewController: UIViewController {

    @IBOutlet var tableView: UITableView!
    
    let dataSource = ColorsDataSource()
    let delegate = ColorsDelegate()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "UITableView + DataSource"
        tableView.dataSource = dataSource
        tableView.delegate = delegate
        tableView.register(ColorsSectionHeaderView.self, forHeaderFooterViewReuseIdentifier: ColorsSectionHeaderView.reuseId)
    }


}
