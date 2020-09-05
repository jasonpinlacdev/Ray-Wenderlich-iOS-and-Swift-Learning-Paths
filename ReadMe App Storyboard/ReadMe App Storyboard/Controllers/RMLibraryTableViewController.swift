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
    
    @IBSegueAction func showDetailView(_ coder: NSCoder) -> RMDetailTableViewController? {
        guard let indexPath = tableView.indexPathForSelectedRow, let book = diffableDataSource.itemIdentifier(for: indexPath) else { fatalError("Nothing selected!") }
        return RMDetailTableViewController(coder: coder, book: book)
    }
    
    private func configureTableView() {
        self.navigationItem.rightBarButtonItem = editButtonItem
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
        diffableDataSource = RMLibraryDiffableDataSource(tableView: tableView) { (tableView, indexPath, book) -> UITableViewCell? in
            if indexPath == IndexPath(row: 0, section: 0) {
                let cell = tableView.dequeueReusableCell(withIdentifier: "RMAddNewBookTableViewCell", for: indexPath)
                return cell
            } else {
                guard let cell = tableView.dequeueReusableCell(withIdentifier: "\(RMBookTableViewCell.self)", for: indexPath) as? RMBookTableViewCell else { fatalError("Could not dequeue a reusable RMTableViewCell.") }
                cell.titleLabel?.text = book.title
                cell.authorLabel?.text = book.author
                
                if let review = book.review {
                    cell.reviewLabel.text = review
                    cell.reviewLabel.isHidden = false
                } else {
                    cell.reviewLabel.isHidden = true
                }
                
                cell.readMeBookmarkImageView.isHidden = book.readMe ?  false : true
                cell.bookThumbnailImageView?.image = book.image ?? RMLibrarySymbol.letterSquare(letter: book.title.first).image
                return cell
            }
        }
    }

}

