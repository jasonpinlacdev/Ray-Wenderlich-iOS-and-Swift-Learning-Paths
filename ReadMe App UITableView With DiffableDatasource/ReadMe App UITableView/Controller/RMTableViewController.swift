//
//  RMTableViewController.swift
//  ReadMe App UITableView
//
//  Created by Jason Pinlac on 2/4/21.
//

import UIKit

enum LibrarySection: String, CaseIterable {
    case addNew
    case readMe = "Read Me!"
    case finished = "Finished"
}

class RMTableViewController: UITableViewController {
    
    var datasource: UITableViewDiffableDataSource<LibrarySection, RMBook>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Read Me Book Library"
        tableView.register(UINib(nibName: "\(RMLibraryHeaderView.self)", bundle: nil), forHeaderFooterViewReuseIdentifier: RMLibraryHeaderView.reuseId)
        configureDatasource()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }
    
    
    @IBSegueAction func showNewBookView(_ coder: NSCoder) -> RMNewBookTableViewController? {
        return RMNewBookTableViewController(coder: coder)
    }
    
    
    @IBSegueAction func showBookDetailView(_ coder: NSCoder) -> RMBookDetailViewController? {
        // diffable datasource
        guard let indexPath = tableView.indexPathForSelectedRow,
              let book = datasource.itemIdentifier(for: indexPath) else { fatalError() }
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
    
}


// MARK: UITableView Diffable Datasource
extension RMTableViewController {
    func configureDatasource() {
        self.datasource = UITableViewDiffableDataSource(tableView: self.tableView, cellProvider: { (tableView, indexPath, book) -> UITableViewCell? in
            if indexPath.section == 0 {
                let cell = tableView.dequeueReusableCell(withIdentifier: "RMNewBookCell", for: indexPath)
                return cell
            } else {
                guard let cell = tableView.dequeueReusableCell(withIdentifier: RMBookCell.reuseId, for: indexPath) as? RMBookCell else { fatalError() }
                cell.set(book: book)
                return cell
            }
        })
        var initialSnapshot = NSDiffableDataSourceSnapshot<LibrarySection, RMBook>()
        initialSnapshot.appendSections(LibrarySection.allCases)

        let booksToRead: [RMBook] = Library.books.filter { $0.readMe }
        let finishedBooks: [RMBook] = Library.books.filter { !$0.readMe }

        initialSnapshot.appendItems([RMBook.mockBook], toSection: .addNew)
        initialSnapshot.appendItems(booksToRead, toSection: .readMe)
        initialSnapshot.appendItems(finishedBooks, toSection: .finished)
        datasource.apply(initialSnapshot)
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
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
    }
    

}
