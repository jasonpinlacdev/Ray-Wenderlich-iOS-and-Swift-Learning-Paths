//
//  ReadMeTableViewDiffableDataSource.swift
//  ReadMe App UITableView with DataSource
//
//  Created by Jason Pinlac on 9/7/21.
//

import UIKit

enum LibrarySection: String, CaseIterable {
  case addNew = "Add New Book"
  case readMe = "Read Me"
  case finished = "Finished"
}

enum LibrarySortStyle {
  case title
  case author
  case readMe
}

class ReadMeTableViewDiffableDataSource: UITableViewDiffableDataSource<LibrarySection, Book> {

  var currentSortStyle = LibrarySortStyle.title
  
  func updateDataSource(sortStyle: LibrarySortStyle, animatingDifferences: Bool) {
    currentSortStyle = sortStyle
   
    var snapshot = NSDiffableDataSourceSnapshot<LibrarySection, Book>()
    snapshot.appendSections(LibrarySection.allCases)
    
    var booksToRead: [Book]
    var finishedBooks: [Book]
    
    switch currentSortStyle {
    case .readMe:
      booksToRead = Library.books.filter { book in book.readMe }
      finishedBooks = Library.books.filter { book in !book.readMe }
    case .title:
      booksToRead = Library.books.filter { book in book.readMe }.sorted { $0.title.localizedCaseInsensitiveCompare($1.title) == .orderedAscending }
      finishedBooks = Library.books.filter { book in !book.readMe }.sorted { $0.title.localizedCaseInsensitiveCompare($1.title) == .orderedAscending }
    case .author:
      booksToRead = Library.books.filter { book in book.readMe }.sorted { $0.author.localizedCaseInsensitiveCompare($1.author) == .orderedAscending }
      finishedBooks = Library.books.filter { book in !book.readMe }.sorted { $0.author.localizedCaseInsensitiveCompare($1.author) == .orderedAscending }
    }
    
    snapshot.appendItems([.mockBook], toSection: .addNew)
    snapshot.appendItems(booksToRead, toSection: .readMe)
    snapshot.appendItems(finishedBooks, toSection: .finished)
    
    self.apply(snapshot, animatingDifferences: animatingDifferences)
  }
  
  override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
    return indexPath.section == self.snapshot().indexOfSection(.addNew) ? false : true
  }
  
  override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
    if editingStyle == .delete {
      guard let book = self.itemIdentifier(for: indexPath) else { return }
      Library.delete(book: book)
      updateDataSource(sortStyle: currentSortStyle, animatingDifferences: true)
    }
  }
  
  override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
    guard currentSortStyle == .readMe else { return false }
    return indexPath.section == self.snapshot().indexOfSection(.addNew) ? false : true
  }
  
  override func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
    guard sourceIndexPath != destinationIndexPath else { updateDataSource(sortStyle: currentSortStyle, animatingDifferences: false); return }
    guard sourceIndexPath.section == destinationIndexPath.section else { updateDataSource(sortStyle: currentSortStyle,animatingDifferences: false); return }
    guard let bookAtSource = self.itemIdentifier(for: sourceIndexPath) else { updateDataSource(sortStyle: currentSortStyle,animatingDifferences: false); return }
    guard let bookAtDestination = self.itemIdentifier(for: destinationIndexPath) else { updateDataSource(sortStyle: currentSortStyle,animatingDifferences: false); return }
    Library.reorderBooks(bookToMove: bookAtSource, bookAtDestination: bookAtDestination)
    updateDataSource(sortStyle: currentSortStyle, animatingDifferences: false)
  }
  
}
