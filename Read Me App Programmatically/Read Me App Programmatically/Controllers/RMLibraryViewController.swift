//
//  ViewController.swift
//  Read Me App Programmatically
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

class RMLibraryViewController: UITableViewController {
    
    var diffableDataSource: RMLibraryDiffableDataSource!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
        configureDiffableDataSource()
        diffableDataSource.update()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        diffableDataSource.update()
    }
    
    private func configureTableView() {
        title = "Read Me Programmatically"
        tableView.rowHeight = 100
        tableView.register(RMAddNewBookTableViewCell.self, forCellReuseIdentifier: RMAddNewBookTableViewCell.reuseId)
        tableView.register(RMBookTableViewCell.self, forCellReuseIdentifier: RMBookTableViewCell.reuseId)
        tableView.register(RMLibraryHeaderView.self, forHeaderFooterViewReuseIdentifier: RMLibraryHeaderView.reuseId)
        navigationItem.rightBarButtonItem = editButtonItem
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

    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return indexPath.section == snapshot().indexOfSection(.addNew) ? false : true
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            guard let book = self.itemIdentifier(for: indexPath) else { return }
            RMLibrary.delete(book: book)
            self.update()
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
        update(animatingDifferences: false)
    }
    
    
    func update(animatingDifferences: Bool = true) {
          var newSnapshot = NSDiffableDataSourceSnapshot<RMLibrarySection, RMBook>()
          newSnapshot.appendSections(RMLibrarySection.allCases)
          
          let booksToRead = RMLibrary.books.compactMap { book in
              return book.readMe ? book : nil
          }
          
          let finishedBooks = RMLibrary.books.compactMap { book in
              return !book.readMe ? book : nil
          }
              
          newSnapshot.appendItems([RMBook.mockBook], toSection: .addNew)
          newSnapshot.appendItems(booksToRead, toSection: .readMe)
          newSnapshot.appendItems(finishedBooks, toSection: .finished)
          self.apply(newSnapshot)
      }
}
