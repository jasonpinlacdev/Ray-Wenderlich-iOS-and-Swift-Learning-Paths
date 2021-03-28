//
//  RMTableViewController.swift
//  ReadMe App UITableView
//
//  Created by Jason Pinlac on 2/4/21.
//

import UIKit

class RMTableViewController: UITableViewController {
    
    @IBOutlet var sortButtons: [UIBarButtonItem]!
    
    var diffDatasource: RMTableViewDiffableDatasource!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Read Me Book Library"
        navigationItem.leftBarButtonItem = editButtonItem
        tableView.register(UINib(nibName: "\(RMLibraryHeaderView.self)", bundle: nil), forHeaderFooterViewReuseIdentifier: RMLibraryHeaderView.reuseId)
        configureDatasource()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        diffDatasource.update(sortStyle: diffDatasource.currentSortStyle, animatingDifferences: false)
//        tableView.reloadData()
    }
    
    
    @IBSegueAction func showNewBookView(_ coder: NSCoder) -> RMNewBookTableViewController? {
        return RMNewBookTableViewController(coder: coder)
    }
    
    
    @IBSegueAction func showBookDetailView(_ coder: NSCoder) -> RMBookDetailViewController? {
        // diffable datasource
        guard let indexPath = tableView.indexPathForSelectedRow,
              let book = diffDatasource.itemIdentifier(for: indexPath) else { fatalError() }
        return RMBookDetailViewController(coder: coder, book: book)
        
        // datasource
//        guard let indexPath = tableView.indexPathForSelectedRow else { fatalError() }
//
//        let booksToRead: [RMBook] = Library.books.filter { $0.readMe }
//        let finishedBooks: [RMBook] = Library.books.filter { !$0.readMe }
//
//        if indexPath.section == 1 {
//            let book: RMBook = booksToRead[indexPath.row]
//            return RMBookDetailViewController(coder: coder, book: book)
//        } else if indexPath.section == 2 {
//            let book: RMBook = finishedBooks[indexPath.row]
//            return RMBookDetailViewController(coder: coder, book: book)
//        }
//        return nil
    }
    
    @IBAction func applyTitleSort(_ sender: UIBarButtonItem) {
        diffDatasource.update(sortStyle: .title, animatingDifferences: true)
        sortButtons.forEach {
            $0.tintColor = ($0 == sender) ? UIColor(named: "ReadMe Tint Color") : .secondaryLabel
        }
        navigationItem.leftBarButtonItem?.isEnabled = false
    }
    
    @IBAction func applyAuthorSort(_ sender: UIBarButtonItem) {
        diffDatasource.update(sortStyle: .author, animatingDifferences: true)
        sortButtons.forEach {
            $0.tintColor = ($0 == sender) ? UIColor(named: "ReadMe Tint Color") : .secondaryLabel
        }
        navigationItem.leftBarButtonItem?.isEnabled = false
    }
    
    @IBAction func applyReadMeSort(_ sender: UIBarButtonItem) {
        diffDatasource.update(sortStyle: .readMe, animatingDifferences: true)
        sortButtons.forEach {
            $0.tintColor = ($0 == sender) ? UIColor(named: "ReadMe Tint Color") : .secondaryLabel
        }
        navigationItem.leftBarButtonItem?.isEnabled = true
    }

}


// MARK: UITableView Diffable Datasource
extension RMTableViewController {
    func configureDatasource() {
        
        self.diffDatasource = RMTableViewDiffableDatasource(tableView: self.tableView, cellProvider: { (tableView, indexPath, book) -> UITableViewCell? in
            if indexPath.section == self.diffDatasource.snapshot().indexOfSection(.addNew) {
                let cell = tableView.dequeueReusableCell(withIdentifier: "RMNewBookCell", for: indexPath)
                return cell
            } else {
                guard let cell = tableView.dequeueReusableCell(withIdentifier: RMBookCell.reuseId, for: indexPath) as? RMBookCell else { fatalError() }
                cell.set(book: book)
                return cell
            }
        })
        
        diffDatasource.update(sortStyle: .readMe, animatingDifferences: false)
    }
}


//MARK: UITableView Datasource
//extension RMTableViewController {
//    override func numberOfSections(in tableView: UITableView) -> Int {
//        return 3
//    }
//
//    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//
//        let booksToRead: [RMBook] = Library.books.filter { $0.readMe }
//        let finishedBooks: [RMBook] = Library.books.filter { !$0.readMe }
//
//        switch section {
//        case 0: return 1
//        case 1: return booksToRead.count
//        case 2: return finishedBooks.count
//        default:
//            return 0
//        }
//    }
//
//    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        switch indexPath.section {
//        case 0:
//            let cell = tableView.dequeueReusableCell(withIdentifier: "RMNewBookCell", for: indexPath)
//            return cell
//        default:
//            guard let cell = tableView.dequeueReusableCell(withIdentifier: RMBookCell.reuseId, for: indexPath) as? RMBookCell else {fatalError()}
//
//            let booksToRead: [RMBook] = Library.books.filter { $0.readMe }
//            let finishedBooks: [RMBook] = Library.books.filter { !$0.readMe }
//
//            let book: RMBook
//            if indexPath.section == 1 {
//              book = booksToRead[indexPath.row]
//                cell.set(book: book)
//            } else if indexPath.section == 2 {
//                book = finishedBooks[indexPath.row]
//                  cell.set(book: book)
//            }
//
//            return cell
//        }
//    }
//
//    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
//        indexPath.section == 0 ? false : true
//    }
//
//    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
//        if editingStyle == .delete {
//            print("delete")
//        }
//    }
//}



// MARK: UITableView Delegate
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
        header.titleLabel.text = LibrarySection.allCases[section].rawValue
        return header
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return section == 0 ? 0 : 60
    }
    
}

