//
//  ViewController.swift
//  ReadMe App Storyboard
//
//  Created by Jason Pinlac on 8/23/20.
//  Copyright © 2020 Jason Pinlac. All rights reserved.
//

import UIKit

enum RMLibrarySection: String, CaseIterable {
    case addNew
    case readMe = "Read Me!"
    case finished = "Finished!"
}

enum RMSortStyle {
    case title
    case author
    case none
}

class RMLibraryTableViewController: UITableViewController {
    
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
    
    @IBSegueAction func showDetailView(_ coder: NSCoder) -> RMDetailTableViewController? {
        guard let indexPath = tableView.indexPathForSelectedRow, let book = diffableDataSource.itemIdentifier(for: indexPath) else { fatalError("Nothing selected!") }
        return RMDetailTableViewController(coder: coder, book: book)
    }
    
    private func configureTableView() {
        self.navigationItem.rightBarButtonItem = editButtonItem
        tableView.register(UINib(nibName: String(describing: RMLibraryHeaderView.self), bundle: nil), forHeaderFooterViewReuseIdentifier: RMLibraryHeaderView.reuseId)
    }
    
    
    @IBAction func sortByTitle(_ sender: UIBarButtonItem) {
        toolbarItems?.forEach { button in
            button.tintColor = button == sender ? UIColor(named: "ReadMe Tint Color") : .secondaryLabel
        }
        diffableDataSource.update(sortStyle: .title)
    }
    
    
    @IBAction func sortByAuthor(_ sender: UIBarButtonItem) {
        toolbarItems?.forEach { button in
            button.tintColor = button == sender ? UIColor(named: "ReadMe Tint Color") : .secondaryLabel
        }
        diffableDataSource.update(sortStyle: .author)
        
    }
    
    @IBAction func sortByNone(_ sender: UIBarButtonItem) {
        toolbarItems?.forEach { button in
            button.tintColor = button == sender ? UIColor(named: "ReadMe Tint Color") : .secondaryLabel
        }
        diffableDataSource.update(sortStyle: .none)
    }
    
}

extension RMLibraryTableViewController {
    
    // MARK: - DELEGATE METHODS -
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        switch section {
        case 0 : return nil
        case 1:
            guard let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: RMLibraryHeaderView.reuseId) as? RMLibraryHeaderView else { return nil }
            headerView.titleLabel?.text = "Read Me!"
            return headerView
        case 2:
            guard let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: RMLibraryHeaderView.reuseId) as? RMLibraryHeaderView else { return nil }
            headerView.titleLabel?.text =  "Finished!"
            return headerView
        default: return nil
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return section == 0 ?  0.0 : 60.0
    }
    
    // MARK: - DATASOURCE METHODS -
    
    func configureDiffableDataSource() {
        diffableDataSource = RMLibraryDiffableDataSource(tableView: tableView) { (tableView, indexPath, book) -> UITableViewCell? in
            if indexPath == IndexPath(row: 0, section: 0) {
                let cell = tableView.dequeueReusableCell(withIdentifier: "RMAddNewBookTableViewCell", for: indexPath)
                return cell
            } else {
                guard let cell = tableView.dequeueReusableCell(withIdentifier: "\(RMBookTableViewCell.self)", for: indexPath) as? RMBookTableViewCell else { fatalError("Could not dequeue a reusable RMTableViewCell.") }
                cell.titleLabel?.text = book.title
                cell.authorLabel?.text = book.author
                
                if let review = book.review {
                    cell.reviewLabel.text = review
                    cell.reviewLabel.isHidden = false
                } else {
                    cell.reviewLabel.isHidden = true
                }
                
                cell.readMeBookmarkImageView.isHidden = book.readMe ?  false : true
                cell.bookThumbnailImageView?.image = book.image ?? RMLibrarySymbol.letterSquare(letter: book.title.first).image
                return cell
            }
        }
    }
    
}

class RMLibraryDiffableDataSource: UITableViewDiffableDataSource<RMLibrarySection, RMBook> {
    
    var currentSortStyle: RMSortStyle = .none
    
    func update(sortStyle: RMSortStyle, animatingDifferences: Bool = true) {
        currentSortStyle = sortStyle
        var newSnapshot = NSDiffableDataSourceSnapshot<RMLibrarySection, RMBook>()
        newSnapshot.appendSections(RMLibrarySection.allCases)
        
        // divide books by readMe or finished
        let booksToRead = RMLibrary.books.compactMap { book in
            return book.readMe ? book : nil
        }
        let finishedBooks = RMLibrary.books.compactMap { book in
            return !book.readMe ? book : nil
        }
        
        // now sort the readMe books and sort the finished books based off of the sortStyle
        let sortedBooksToRead: [RMBook]
        let sortedFinishedBooks: [RMBook]
        
        switch sortStyle {
        case .title:
            sortedBooksToRead = booksToRead.sorted { (bookA, bookB) -> Bool in
                bookA.title.localizedCaseInsensitiveCompare(bookB.title) == .orderedAscending
            }
            sortedFinishedBooks = finishedBooks.sorted { (bookA, bookB) -> Bool in
                bookA.title.localizedCaseInsensitiveCompare(bookB.title) == .orderedAscending
            }
        case .author:
            sortedBooksToRead = booksToRead.sorted { (bookA, bookB) -> Bool in
                bookA.author.localizedCaseInsensitiveCompare(bookB.author) == .orderedAscending
            }
            sortedFinishedBooks = finishedBooks.sorted { (bookA, bookB) -> Bool in
                bookA.author.localizedCaseInsensitiveCompare(bookB.author) == .orderedAscending
            }
        case .none:
            sortedBooksToRead = booksToRead
            sortedFinishedBooks = finishedBooks
        }
        
        newSnapshot.appendItems([RMBook.mockBook], toSection: .addNew)
        newSnapshot.appendItems(sortedBooksToRead, toSection: .readMe)
        newSnapshot.appendItems(sortedFinishedBooks, toSection: .finished)
        self.apply(newSnapshot, animatingDifferences: animatingDifferences)
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
        guard currentSortStyle == .none else { return false }
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
        update(sortStyle: currentSortStyle, animatingDifferences: false)
    }
}

