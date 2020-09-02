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

class RMLibraryTableViewController: UITableViewController {
    
    var diffableDataSource: UITableViewDiffableDataSource<RMLibrarySection, RMBook>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
        configureDiffableDataSource()
        updateDiffableDataSource()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        updateDiffableDataSource()
    }
    
    @IBSegueAction func showDetailView(_ coder: NSCoder) -> RMDetailTableViewController? {
        guard let indexPath = tableView.indexPathForSelectedRow, let book = diffableDataSource.itemIdentifier(for: indexPath) else { fatalError("Nothing selected!") }
        return RMDetailTableViewController(coder: coder, book: book)
    }
    
    private func configureTableView() {
        tableView.register(UINib(nibName: String(describing: RMLibraryHeaderView.self), bundle: nil), forHeaderFooterViewReuseIdentifier: RMLibraryHeaderView.reuseId)
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
        diffableDataSource = UITableViewDiffableDataSource(tableView: tableView) { (tableView, indexPath, book) -> UITableViewCell? in
            if indexPath == IndexPath(row: 0, section: 0) {
                let cell = tableView.dequeueReusableCell(withIdentifier: "RMAddNewBookTableViewCell", for: indexPath)
                return cell
            } else {
                guard let cell = tableView.dequeueReusableCell(withIdentifier: "\(RMBookTableViewCell.self)", for: indexPath) as? RMBookTableViewCell else { fatalError("Could not dequeue a reusable RMTableViewCell.") }
                cell.titleLabel?.text = book.title
                cell.authorLabel?.text = book.author
                cell.bookThumbnailImageView?.image = book.image ?? RMLibrarySymbol.letterSquare(letter: book.title.first).image
                return cell
            }
        }
    }
    
    func updateDiffableDataSource() {
        var newSnapshot = NSDiffableDataSourceSnapshot<RMLibrarySection, RMBook>()
        newSnapshot.appendSections(RMLibrarySection.allCases)
        
        let booksToRead = RMLibrary.books.compactMap { book in
            return book.readMe ? book : nil
        }
        let booksFinishedReading = RMLibrary.books.compactMap { book in
            return !book.readMe ? book : nil
        }
        
        newSnapshot.appendItems([RMBook.mockBook], toSection: .addNew)
        newSnapshot.appendItems(booksToRead, toSection: .readMe)
        newSnapshot.appendItems(booksFinishedReading, toSection: .finished)
        diffableDataSource.apply(newSnapshot, animatingDifferences: true)
    }
    
}

