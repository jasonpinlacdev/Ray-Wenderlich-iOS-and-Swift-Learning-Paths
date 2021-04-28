//
//  ColorsViewController.swift
//  UITableView DiffDataSource SectionHeaderFooterSupplementaryViews
//
//  Created by Jason Pinlac on 3/30/21.
//

import UIKit

class ColorsViewController: UIViewController {
    
    @IBOutlet var tableView: UITableView!
    
    var diffableDataSource: ColorsDiffableDataSource!
    let delegate = ColorsDelegate()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "UITableView + Diffable DataSource"
        tableView.register(ColorsSectionHeaderView.self, forHeaderFooterViewReuseIdentifier: ColorsSectionHeaderView.reuseId)
        tableView.delegate = delegate
        configureDiffDataSource()
    }
    
    func configureDiffDataSource() {
        diffableDataSource = ColorsDiffableDataSource(tableView: tableView, cellProvider: { (tableView, indexPath, color) -> UITableViewCell? in
            guard let colorsTableViewCell = tableView.dequeueReusableCell(withIdentifier: ColorsTableViewCell.reuseId, for: indexPath) as? ColorsTableViewCell else { fatalError() }
            colorsTableViewCell.set(color: color)
            return colorsTableViewCell
        })
        var snapshot = NSDiffableDataSourceSnapshot<Data.ColorsSection, Color>()
        let sections = Data.ColorsSection.allCases
        snapshot.appendSections(sections)
        sections.forEach {
            if let colorsForSection = Data.shared.colors[$0] {
                snapshot.appendItems(colorsForSection, toSection: $0)
            }
        }
        diffableDataSource.apply(snapshot)
    }
    
}
