//
//  RMTableViewController.swift
//  ReadMe App UITableView
//
//  Created by Jason Pinlac on 2/4/21.
//

import UIKit


class RMTableViewController: UITableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Read Me Book Library"
        tableView.register(UINib(nibName: "\(RMLibraryHeaderView.self)", bundle: nil), forHeaderFooterViewReuseIdentifier: RMLibraryHeaderView.reuseId)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }
    
    
    @IBSegueAction func showNewBookView(_ coder: NSCoder) -> RMNewBookTableViewController? {
        return RMNewBookTableViewController(coder: coder)
    }
    
    
    @IBSegueAction func showBookDetailView(_ coder: NSCoder) -> RMBookDetailViewController? {
        guard let indexPath = tableView.indexPathForSelectedRow else { fatalError() }
        let book = Library.books[indexPath.row]
        return RMBookDetailViewController(coder: coder, book: book)
    }
    
    
}


// MARK: UITableViewDatasource
extension RMTableViewController {
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0: return 1
        default: return Library.books.count
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: "RMNewBookCell", for: indexPath)
            return cell
        default:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "RMBookCell", for: indexPath) as? RMBookCell else {fatalError()}
            let book = Library.books[indexPath.row]
            cell.book = book
            return cell
        }
    }
}


// MARK: UITableViewDelegate
extension RMTableViewController {
//    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
//        switch section {
//        case 0: return nil
//        case 1: return "Read Me!"
//        default: return nil
//        }
//    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if section == 0 { return nil }
        guard let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: RMLibraryHeaderView.reuseId) as? RMLibraryHeaderView else { return nil }
        header.titleLabel.text = "Read Me!"
        return header
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return section == 0 ? 0 : 60
    }
    

}
