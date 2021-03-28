//
//  RMTableViewDiffableDatasource.swift
//  ReadMe App UITableView With DiffableDatasource
//
//  Created by Jason Pinlac on 2/28/21.
//

import UIKit

enum LibrarySection: String, CaseIterable {
    case addNew
    case readMe = "Read Me!"
    case finished = "Finished"
}

enum SortStyle {
    case title
    case author
    case readMe
}

class RMTableViewDiffableDatasource: UITableViewDiffableDataSource<LibrarySection, RMBook> {
    
    var currentSortStyle: SortStyle = .title
    
    func update(sortStyle: SortStyle, animatingDifferences: Bool) {
        currentSortStyle = sortStyle
        var snapshot = NSDiffableDataSourceSnapshot<LibrarySection, RMBook>()
        snapshot.appendSections(LibrarySection.allCases)
        snapshot.appendItems([RMBook.mockBook], toSection: .addNew)
        
        let booksByReadme: [Bool: [RMBook]] = Dictionary(grouping: Library.books, by: \.readMe)
        for (readMe, books) in booksByReadme {
            let sortedBooks: [RMBook]
            switch sortStyle {
            case .title:
                sortedBooks = books.sorted { $0.title.localizedCaseInsensitiveCompare($1.title) == .orderedAscending }
            case .author:
                sortedBooks = books.sorted { $0.author.localizedCaseInsensitiveCompare($1.author) == .orderedAscending }
            case .readMe:
                sortedBooks = books
            }
            snapshot.appendItems(sortedBooks, toSection: readMe ? .readMe : .finished)
        }
        self.apply(snapshot, animatingDifferences: animatingDifferences)
    }
    
    
    // override these two datasource protol methods in this UIDiffableDatasource subclass. Remember, diffable datasource is a class not a protocol. So, if your tableview datasource is a diffable datasource you override these two methods in the subclass instead of providing the implemetation for the datasouce protocol.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        indexPath.section ==    self.snapshot().indexOfSection(.addNew) ? false : true
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            guard let bookToDelete = self.itemIdentifier(for: indexPath) else { fatalError() }
            Library.delete(book: bookToDelete)
            update(sortStyle: currentSortStyle, animatingDifferences: true)
        }
    }
    
    // override these two datasource protocol methods in this diffable datasource subclass.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        indexPath.section == self.snapshot().indexOfSection(.addNew) ? false : true
    }
    
    override func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        guard currentSortStyle == .readMe,
              sourceIndexPath != destinationIndexPath,
              sourceIndexPath.section == destinationIndexPath.section,
              let bookToMove = self.itemIdentifier(for: sourceIndexPath),
              let bookAtDestination = self.itemIdentifier(for: destinationIndexPath)
        else {
            self.apply(snapshot(),animatingDifferences: false)
            return
        }
        Library.reorderBooks(bookToMove: bookToMove, bookAtDestination: bookAtDestination)
        update(sortStyle: currentSortStyle, animatingDifferences: false)
    }
    
}
