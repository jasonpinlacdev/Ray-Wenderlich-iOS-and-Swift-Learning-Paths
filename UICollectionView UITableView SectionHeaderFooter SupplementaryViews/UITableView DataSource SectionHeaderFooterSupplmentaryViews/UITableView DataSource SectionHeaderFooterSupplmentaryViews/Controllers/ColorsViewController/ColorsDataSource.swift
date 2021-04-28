//
//  ColorsDataSource.swift
//  UITableView DataSource SectionHeaderFooterSupplmentaryViews
//
//  Created by Jason Pinlac on 3/30/21.
//

import UIKit

class ColorsDataSource: NSObject {

}

extension ColorsDataSource: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        Data.ColorsSection.allCases.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let sectionCategory = Data.ColorsSection.allCases[section]
        guard let colorsInSection = Data.shared.colors[sectionCategory] else {  fatalError() }
        return colorsInSection.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let colorCell = tableView.dequeueReusableCell(withIdentifier: ColorCell.reuseId, for: indexPath) as? ColorCell else { fatalError() }
        let sectionCategory = Data.ColorsSection.allCases[indexPath.section]
        guard let colorsInSection = Data.shared.colors[sectionCategory] else {  fatalError() }
        let color = colorsInSection[indexPath.row]
        colorCell.set(color: color)
        return colorCell
    }
    
//    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
//        let title = Data.ColorsSection.allCases[section].rawValue
//        return title
//    }

}
