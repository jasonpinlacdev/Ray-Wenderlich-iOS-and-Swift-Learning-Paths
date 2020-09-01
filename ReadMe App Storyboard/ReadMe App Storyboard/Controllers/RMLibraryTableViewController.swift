//
//  ViewController.swift
//  ReadMe App Storyboard
//
//  Created by Jason Pinlac on 8/23/20.
//  Copyright © 2020 Jason Pinlac. All rights reserved.
//

import UIKit

class RMLibraryTableViewController: UITableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }
    
    @IBSegueAction func showDetailView(_ coder: NSCoder) -> RMDetailTableViewController? {
        guard let indexPath = tableView.indexPathForSelectedRow else { fatalError("Nothing selected!") }
        let book = RMLibrary.books[indexPath.row]
        return RMDetailTableViewController(coder: coder, book: book)
    }
    
    private func configureTableView() {
        tableView.register(UINib(nibName: String(describing: RMLibraryHeaderView.self), bundle: nil), forHeaderFooterViewReuseIdentifier: RMLibraryHeaderView.reuseId)
    }
    
    
}

extension RMLibraryTableViewController {
    
    // MARK: - DELEGATE METHODS -
    
//    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
//        return section == 0 ? nil : "Read Me!"
//    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if section == 0 { return nil }
        guard let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: RMLibraryHeaderView.reuseId) as? RMLibraryHeaderView else { return nil }
        headerView.titleLabel?.text = "Read Me!"
        return headerView
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return section == 1 ? 60.0 : 0.0
    }

    
    // MARK: - DATASOURCE METHODS -
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return section == 0 ? 1 : RMLibrary.books.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath == IndexPath(row: 0, section: 0) {
            let cell = tableView.dequeueReusableCell(withIdentifier: "RMAddNewBookTableViewCell", for: indexPath)
            return cell
        } else {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "\(RMBookTableViewCell.self)", for: indexPath) as? RMBookTableViewCell else { fatalError("Could not dequeue a reusable RMTableViewCell.") }
            let book = RMLibrary.books[indexPath.row]
            cell.titleLabel?.text = book.title
            cell.authorLabel?.text = book.author
            cell.bookThumbnailImageView?.image = book.image
            return cell
        }
    }
    
    
}

