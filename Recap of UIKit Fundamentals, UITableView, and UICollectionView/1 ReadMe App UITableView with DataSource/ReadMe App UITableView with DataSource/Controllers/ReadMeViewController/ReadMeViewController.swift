//
//  ViewController.swift
//  ReadMe App UITableView with DataSource
//
//  Created by Jason Pinlac on 9/3/21.
//

import UIKit

class ReadMeViewController: UIViewController {
  
  @IBOutlet var sortStyleButtons: [UIBarButtonItem]!
  
  @IBOutlet var tableView: UITableView!
  //  let readMeTableViewDataSource = ReadMeTableViewDataSource()
  var readMeDiffableDataSource: ReadMeTableViewDiffableDataSource!
  let readMeTableViewDelegate = ReadMeTableViewDelegate()
  
  
  override func viewDidLoad() {
    super.viewDidLoad()
    title = "Read Me Library"
    navigationItem.rightBarButtonItem = editButtonItem
    //    tableView.dataSource = self.readMeTableViewDataSource
    configureDiffableDataSource()
    tableView.delegate = self.readMeTableViewDelegate
    tableView.register(UINib(nibName: "\(LibraryHeaderView.self)", bundle: nil), forHeaderFooterViewReuseIdentifier: LibraryHeaderView.reuseIdentifier)
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
//    tableView.reloadData()
    readMeDiffableDataSource.updateDataSource(sortStyle: readMeDiffableDataSource.currentSortStyle, animatingDifferences: false)
  }
  
  override func setEditing(_ editing: Bool, animated: Bool) {
      super.setEditing(editing, animated: animated)
      tableView.setEditing(editing, animated: animated)
  }
  
  private func configureDiffableDataSource() {
    readMeDiffableDataSource = ReadMeTableViewDiffableDataSource(tableView: tableView, cellProvider: { tableView, indexPath, book in
      if indexPath.section == 0 {
        let cell = tableView.dequeueReusableCell(withIdentifier: "AddNewBookTableViewCell", for: indexPath)
        return cell
      } else {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "BookTableViewCell", for: indexPath) as? BookTableViewCell else { fatalError("Failed to dequeue a BookTableViewCell.") }
        cell.titleLable.text = book.title
        cell.authorLabel.text = book.author
        cell.reviewLabel.text = book.review ?? "No Review..."
        cell.bookImageView.image = book.image ?? LibrarySymbol.letterSquare(letter: book.title.first).image
        cell.bookImageView.layer.cornerRadius = 12
        cell.bookMarkImageView.isHidden = !book.readMe
        return cell
      }
    })
    readMeDiffableDataSource.updateDataSource(sortStyle: .readMe, animatingDifferences: false)
  }
  
  
  @IBSegueAction func showAddNewBookViewController(_ coder: NSCoder) -> AddNewBookViewController? {
    return AddNewBookViewController(coder: coder)
  }
  
  @IBSegueAction func showBookDetailViewController(_ coder: NSCoder) -> BookDetailTableViewController? {
    guard let selectedIndexPath = tableView.indexPathForSelectedRow else { return nil }
    guard let book = readMeDiffableDataSource.itemIdentifier(for: selectedIndexPath) else { return nil }
//    let book = Library.books[selectedIndexPath.row]
    let bookDetailViewController = BookDetailTableViewController(coder: coder, book: book)
    return bookDetailViewController
  }
  
  //  override func prepare(for segue: mUIStoryboardSegue, sender: Any?) {
  //    if segue.identifier == "BookDetailViewController" {
  //      guard let bookDetailViewController = segue.destination as? BookDetailViewController else { return }
  //      guard let selectedIndexPath = tableView.indexPathForSelectedRow else { return }
  //      bookDetailViewController.book = Library.books[selectedIndexPath.row]
  //    }
  //  }
  
  @IBAction func sortByReadme(_ sender: UIBarButtonItem) {
    sender.tintColor = UIColor(named: "ReadMe Tint Color")
    sortStyleButtons.forEach { button in
      if button != sender {
        button.tintColor = .secondaryLabel
      }
    }
    readMeDiffableDataSource.updateDataSource(sortStyle: .readMe, animatingDifferences: true)
  }
  
  @IBAction func sortByTitle(_ sender: UIBarButtonItem) {
    sender.tintColor = UIColor(named: "ReadMe Tint Color")
    sortStyleButtons.forEach { button in
      if button != sender {
        button.tintColor = .secondaryLabel
      }
    }
    readMeDiffableDataSource.updateDataSource(sortStyle: .title, animatingDifferences: true)
  }
  @IBAction func sortByAuthor(_ sender: UIBarButtonItem) {
    sender.tintColor = UIColor(named: "ReadMe Tint Color")
    sortStyleButtons.forEach { button in
      if button != sender {
        button.tintColor = .secondaryLabel
      }
    }
    readMeDiffableDataSource.updateDataSource(sortStyle: .author, animatingDifferences: true)
  }
}
