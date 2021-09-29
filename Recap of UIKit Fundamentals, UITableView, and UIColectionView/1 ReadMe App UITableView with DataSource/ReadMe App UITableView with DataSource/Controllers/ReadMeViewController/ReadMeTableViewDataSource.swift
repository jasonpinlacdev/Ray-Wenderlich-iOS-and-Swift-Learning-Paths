//
//  ReadMeTableViewDataSource.swift
//  ReadMe App UITableView with DataSource
//
//  Created by Jason Pinlac on 9/3/21.
//

import UIKit

class ReadMeTableViewDataSource: NSObject {
  
}


extension ReadMeTableViewDataSource: UITableViewDataSource {
  
  func numberOfSections(in tableView: UITableView) -> Int {
    2
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    if section == 0 {
      return 1
    } else {
      return Library.books.count
    }
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    if indexPath.section == 0 {
      let cell = tableView.dequeueReusableCell(withIdentifier: "AddNewBookTableViewCell", for: indexPath)
      return cell
    } else {
      guard let cell = tableView.dequeueReusableCell(withIdentifier: "BookTableViewCell", for: indexPath) as? BookTableViewCell else { fatalError("Failed to dequeue a BookTableViewCell.") }
      let book = Library.books[indexPath.row]
      cell.bookImageView.image = book.image
      cell.bookImageView.layer.cornerRadius = 12
      cell.titleLable.text = book.title
      cell.authorLabel.text = book.author
      cell.reviewLabel.text = book.review ?? "No Review..."
      return cell
    }
  }
  
//  func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
//    return section == 1 ? "Read Me!" : nil
//  }
  
}
