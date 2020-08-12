//
//  ViewController.swift
//  UITableView Diffable Data Source
//
//  Created by Jason Pinlac on 7/30/20.
//  Copyright © 2020 Jason Pinlac. All rights reserved.
//

import UIKit

class LibraryViewController: UITableViewController {
    
    var dataSource: LibraryDiffableDataSource!
    
    @IBOutlet var sortButtons: [UIBarButtonItem]!
    
    
    @IBAction func sortByTitle(_ sender: UIBarButtonItem) {
        dataSource.update(sortStyle: .title, animatingDifferences: true)
        updateTintColorFor(selectedSortButton: sender)
    }
    
    
    @IBAction func sortByAuthor(_ sender: UIBarButtonItem) {
        dataSource.update(sortStyle: .author, animatingDifferences: true)
        updateTintColorFor(selectedSortButton: sender)
    }
    
    
    @IBAction func sortByReadMe(_ sender: UIBarButtonItem) {
        dataSource.update(sortStyle: .readme, animatingDifferences: true)
        updateTintColorFor(selectedSortButton: sender)
    }
    
    
    func updateTintColorFor(selectedSortButton: UIBarButtonItem) {
        sortButtons.forEach { button in
            if button == selectedSortButton {
                button.tintColor = button.customView?.tintColor
            } else {
                button.tintColor = .secondaryLabel
            }
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        tableView.register(UINib(nibName: "\(LibraryHeaderView.self)", bundle: nil), forHeaderFooterViewReuseIdentifier: LibraryHeaderView.reuseIdentifier)
        configureDataSource()
        dataSource.update(sortStyle: .readme, animatingDifferences: false)
        navigationItem.rightBarButtonItem = editButtonItem
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //        tableView.reloadData()
        dataSource.update(sortStyle: dataSource.currentSortStyle, animatingDifferences: true)
    }
    
}


extension LibraryViewController {
    
    // MARK: - Delegate -
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath == IndexPath(row: 0, section: 0) {
        } else {
            guard let detailViewController = storyboard?.instantiateViewController(withIdentifier: "DetailViewController") as? DetailViewController else { return }
            //            detailViewController.book = Library.books[indexPath.row]
            detailViewController.book = dataSource.itemIdentifier(for: indexPath)
            navigationController?.pushViewController(detailViewController, animated: true)
        }
    }
    
    
    //    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
    //        return section == 1 ? "Read Me!" : nil
    //    }
    
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if section == 0 { return nil }
        guard let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: LibraryHeaderView.reuseIdentifier) as? LibraryHeaderView else { return nil }
        headerView.titleLabel?.text = Section.allCases[section].rawValue
        return headerView
    }
    
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return section == 0 ? 0 : 60
    }
    
    
    // MARK: - Diffable DataSource -
    func configureDataSource() {
        dataSource = LibraryDiffableDataSource(tableView: tableView, cellProvider: { (tableView, indexPath, book) -> UITableViewCell? in
            if indexPath == IndexPath(row: 0, section: 0) {
                let cell = tableView.dequeueReusableCell(withIdentifier: "NewBookCell", for: indexPath)
                return cell
            } else {
                guard let cell = tableView.dequeueReusableCell(withIdentifier: "BookCell", for: indexPath) as? BookCell else { fatalError() }
                cell.titleLabel.text = book.title
                cell.authorLabel.text = book.author
                cell.bookThumbnail.image = book.image ?? LibrarySymbol.letterSquare(letter: book.title.first).image
                cell.bookThumbnail.layer.cornerRadius = 12
                if let review = book.review {
                    cell.reviewLabel.text = review
                    cell.reviewLabel.isHidden = false
                }
                cell.readMeBookMark.isHidden = !book.readMe
                return cell
            }
        })
    }
}

//     //MARK: - Original Datasource Code -
//        override func numberOfSections(in tableView: UITableView) -> Int {
//            return 2
//        }
//
//        override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//            return section == 0 ? 1 : Library.books.count
//
//        }
//
//        override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//            if indexPath == IndexPath(row: 0, section: 0) {
//                let cell = tableView.dequeueReusableCell(withIdentifier: "NewBookCell", for: indexPath)
//                return cell
//            } else {
//                guard let cell = tableView.dequeueReusableCell(withIdentifier: "BookCell", for: indexPath) as? BookCell else { fatalError() }
//                let book = Library.books[indexPath.row]
//                cell.titleLabel.text = book.title
//                cell.authorLabel.text = book.author
//                cell.bookThumbnail.image = book.image
//                cell.bookThumbnail.layer.cornerRadius = 12
//                return cell
//            }
//        }










