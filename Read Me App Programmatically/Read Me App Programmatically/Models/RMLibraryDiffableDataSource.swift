//
//  RMLibraryDiffableDataSource.swift
//  Read Me App Programmatically
//
//  Created by Jason Pinlac on 9/5/20.
//  Copyright © 2020 Jason Pinlac. All rights reserved.
//

import UIKit

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
    
    
    func update() {
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
