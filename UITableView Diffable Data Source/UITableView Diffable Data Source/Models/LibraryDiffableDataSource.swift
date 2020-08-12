//
//  LibraryDiffableDataSource.swift
//  UITableView Diffable Data Source
//
//  Created by Jason Pinlac on 8/11/20.
//  Copyright © 2020 Jason Pinlac. All rights reserved.
//

import UIKit

enum SortStyle {
    case title
    case author
    case readme
}

enum Section: String, CaseIterable {
    case addNew
    case readMe = "Read Me!"
    case finished = "Finished!"
}

class LibraryDiffableDataSource: UITableViewDiffableDataSource<Section, Book> {
    
    var currentSortStyle: SortStyle = .title
    
    func update(sortStyle: SortStyle, animatingDifferences: Bool) {
        currentSortStyle = sortStyle
        
        var newSnapShot = NSDiffableDataSourceSnapshot<Section, Book>()
        newSnapShot.appendSections(Section.allCases)
        let booksByReadMe: [Bool: [Book]] = Dictionary(grouping: Library.books, by: \.readMe)
        for (isReadMe, books) in booksByReadMe {
            var sortedBooks: [Book]
            
            switch sortStyle {
            case .title:
                sortedBooks = books.sorted { $0.title.localizedCaseInsensitiveCompare($1.title) == .orderedAscending }
            case .author:
                sortedBooks = books.sorted { $0.author.localizedCaseInsensitiveCompare($1.author) == .orderedAscending }
            case .readme:
                sortedBooks = books
            }
            
            newSnapShot.appendItems(sortedBooks, toSection: isReadMe ? .readMe : .finished)
        }
        newSnapShot.appendItems([Book.mockBook], toSection: .addNew)
        self.apply(newSnapShot, animatingDifferences: animatingDifferences)
    }
    
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return indexPath.section == snapshot().indexOfSection(.addNew) ? false : true
    }
    
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            guard let book = self.itemIdentifier(for: indexPath) else { return }
            Library.delete(book: book)
            self.update(sortStyle: currentSortStyle, animatingDifferences: true)
        }
    }
    
    
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        if indexPath.section != snapshot().indexOfSection(.addNew) && currentSortStyle == .readme {
            return true
        } else {
            return false
        }
    }
    
    
    override func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        guard
            sourceIndexPath != destinationIndexPath,
            sourceIndexPath.section == destinationIndexPath.section,
        let bookToMove = itemIdentifier(for: sourceIndexPath),
        let bookAtDestination = itemIdentifier(for: destinationIndexPath)
            else {
                apply(snapshot(), animatingDifferences: false)
                return
        }
        Library.reorderBooks(bookToMove: bookToMove, bookAtDestination: bookAtDestination)
        update(sortStyle: currentSortStyle, animatingDifferences: false)
    }

}
