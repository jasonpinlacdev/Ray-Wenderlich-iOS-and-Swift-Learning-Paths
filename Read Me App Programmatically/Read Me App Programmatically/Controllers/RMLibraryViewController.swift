//
//  ViewController.swift
//  Read Me App Programmatically
//
//  Created by Jason Pinlac on 8/23/20.
//  Copyright © 2020 Jason Pinlac. All rights reserved.
//

import UIKit

enum RMSortStyle {
    case title
    case author
    case none
}

enum RMLibrarySection: String, CaseIterable {
    case addNew
    case readMe = "Read Me!"
    case finished = "Finished!"
}

class RMLibraryViewController: UITableViewController {
    
    var diffableDataSource: RMLibraryDiffableDataSource!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
        configureDiffableDataSource()
        diffableDataSource.update(sortStyle: diffableDataSource.currentSortStyle)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        diffableDataSource.update(sortStyle: diffableDataSource.currentSortStyle)
    }
    
    private func configureTableView() {
        title = "Read Me Programmatically"
        tableView.rowHeight = 100
        tableView.register(RMAddNewBookTableViewCell.self, forCellReuseIdentifier: RMAddNewBookTableViewCell.reuseId)
        tableView.register(RMBookTableViewCell.self, forCellReuseIdentifier: RMBookTableViewCell.reuseId)
        tableView.register(RMLibraryHeaderView.self, forHeaderFooterViewReuseIdentifier: RMLibraryHeaderView.reuseId)
        navigationItem.rightBarButtonItem = editButtonItem
        
        let sortByTitleBarButtonItem = UIBarButtonItem(title: "Title", style: .plain, target: self, action: #selector(sortByTitleTapped(_:)))
        sortByTitleBarButtonItem.tintColor = .secondaryLabel
        let sortByAuthorBarButtonItem = UIBarButtonItem(title: "Author", style: .plain, target: self, action: #selector(sortByAuthorTapped(_:)))
        sortByAuthorBarButtonItem.tintColor = .secondaryLabel
        let sortByNoneButtonItem = UIBarButtonItem(title: "None", style: .plain, target: self, action: #selector(sortByNoneTapped(_:)))
        sortByNoneButtonItem.tintColor = UIColor(named: "ReadMe Tint Color")
        
        setToolbarItems([
            UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil),
            sortByTitleBarButtonItem,
            UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil),
            sortByAuthorBarButtonItem,
            UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil),
            sortByNoneButtonItem,
            UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil),
            
        ], animated: false)
    }
    
    @objc func sortByTitleTapped(_ sender: UIBarButtonItem) {
        toolbarItems?.forEach { button in
            button.tintColor = (button == sender) ? UIColor(named: "ReadMe Tint Color") : .secondaryLabel
        }
        diffableDataSource.update(sortStyle: .title)
    }
    @objc func sortByAuthorTapped(_ sender: UIBarButtonItem) {
        toolbarItems?.forEach { button in
            button.tintColor = (button == sender) ? UIColor(named: "ReadMe Tint Color") : .secondaryLabel
        }
        diffableDataSource.update(sortStyle: .author)
    }
    @objc func sortByNoneTapped(_ sender: UIBarButtonItem) {
        toolbarItems?.forEach { button in
            button.tintColor = (button == sender) ? UIColor(named: "ReadMe Tint Color") : .secondaryLabel
        }
        diffableDataSource.update(sortStyle: .none)
    }
    
}

extension RMLibraryViewController {
    
    // MARK: - UITableViewDelegate Methods -
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return section == 0 ? 0.0 : 60.0
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        switch section {
        case 0: return nil
        case 1:
            guard let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: RMLibraryHeaderView.reuseId) as? RMLibraryHeaderView else { fatalError("Unknown header view dequeued") }
            headerView.headerLabel.text = RMLibrarySection.readMe.rawValue
            return headerView
        case 2:
            guard let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: RMLibraryHeaderView.reuseId) as? RMLibraryHeaderView else { fatalError("Unknown header view dequeued") }
            headerView.headerLabel.text = RMLibrarySection.finished.rawValue
            return headerView
        default: fatalError("Uknown header view for unknow section.")
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        if indexPath == IndexPath(row: 0, section: 0) {
            let newBookTableViewController = RMNewBookTableViewController()
            navigationController?.pushViewController(newBookTableViewController, animated: true)
        } else {
            guard let book = diffableDataSource.itemIdentifier(for: indexPath) else { fatalError("Unknown book on row selection for detail view controller") }
            let detailTableViewController = RMDetailTableViewController(book: book)
            navigationController?.pushViewController(detailTableViewController, animated: true)
        }
    }
    
    // MARK: - UITableViewDatasource Methods -
    
    func configureDiffableDataSource() {
        diffableDataSource = RMLibraryDiffableDataSource(tableView: self.tableView, cellProvider: { (tableView, indexPath, book) -> UITableViewCell? in
            // this closure function is exactly the same as cellForRowAt
            if indexPath.section == 0 {
                return tableView.dequeueReusableCell(withIdentifier: RMAddNewBookTableViewCell.reuseId, for: indexPath)
            } else {
                guard let cell = tableView.dequeueReusableCell(withIdentifier: RMBookTableViewCell.reuseId, for: indexPath) as? RMBookTableViewCell else { fatalError("Failed to dequeue a RMBookTableViewCell") }
                cell.titleLabel.text = book.title
                cell.authorLabel.text = book.author
                
                if let review = book.review {
                    cell.reviewLabel.text = review
                    cell.reviewLabel.isHidden = false
                } else {
                    cell.reviewLabel.isHidden = true
                }
                
                cell.bookmarkImageView.isHidden = book.readMe ?  false : true
                cell.bookThumbnailImageView.image = book.image ?? RMLibrarySymbol.letterSquare(letter: book.title.first).image
                return cell
            }
        })
    }
    
}

class RMLibraryDiffableDataSource: UITableViewDiffableDataSource<RMLibrarySection, RMBook> {
    
    var currentSortStyle: RMSortStyle = .none
    
    func update(sortStyle: RMSortStyle, animatingDifferences: Bool = true) {
        currentSortStyle = sortStyle
        var newSnapshot = NSDiffableDataSourceSnapshot<RMLibrarySection, RMBook>()
        newSnapshot.appendSections(RMLibrarySection.allCases)
        
        let booksToRead = RMLibrary.books.compactMap { book in
            return book.readMe ? book : nil
        }
        
        let finishedBooks = RMLibrary.books.compactMap { book in
            return !book.readMe ? book : nil
        }
        
        let sortedBooksToRead: [RMBook]
        let sortedFinishedBooks: [RMBook]
        switch currentSortStyle {
        case .title:
            sortedBooksToRead = booksToRead.sorted { aBook, bBook in
                aBook.title.localizedCaseInsensitiveCompare(bBook.title) == .orderedAscending
            }
            sortedFinishedBooks = finishedBooks.sorted { aBook, bBook in
                aBook.title.localizedCaseInsensitiveCompare(bBook.title) == .orderedAscending
            }
        case .author:
            sortedBooksToRead = booksToRead.sorted { aBook, bBook in
                aBook.author.localizedCaseInsensitiveCompare(bBook.author) == .orderedAscending
            }
            sortedFinishedBooks = finishedBooks.sorted { aBook, bBook in
                aBook.author.localizedCaseInsensitiveCompare(bBook.author) == .orderedAscending
            }
        case .none:
            sortedBooksToRead = booksToRead
            sortedFinishedBooks = finishedBooks
        }
        
        newSnapshot.appendItems([RMBook.mockBook], toSection: .addNew)
        newSnapshot.appendItems(sortedBooksToRead, toSection: .readMe)
        newSnapshot.appendItems(sortedFinishedBooks, toSection: .finished)
        self.apply(newSnapshot)
    }
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return indexPath.section == snapshot().indexOfSection(.addNew) ? false : true
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            guard let book = self.itemIdentifier(for: indexPath) else { return }
            RMLibrary.delete(book: book)
            self.update(sortStyle: currentSortStyle)
        }
    }
    
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        return indexPath.section == snapshot().indexOfSection(.addNew) ? false : true
    }
    
    override func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        guard sourceIndexPath != destinationIndexPath,
            sourceIndexPath.section == destinationIndexPath.section,
            let bookAtSourceIndexPath = itemIdentifier(for: sourceIndexPath),
            let bookAtDestinationIndexPath = itemIdentifier(for: destinationIndexPath)
            else {
                apply(snapshot(), animatingDifferences: false)
                return
        }
        RMLibrary.reorderBooks(bookToMove: bookAtSourceIndexPath, bookAtDestination: bookAtDestinationIndexPath)
        self.update(sortStyle: currentSortStyle)
    }
    
}
