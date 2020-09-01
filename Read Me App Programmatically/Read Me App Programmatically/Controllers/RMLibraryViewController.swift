//
//  ViewController.swift
//  Read Me App Programmatically
//
//  Created by Jason Pinlac on 8/23/20.
//  Copyright © 2020 Jason Pinlac. All rights reserved.
//

import UIKit

class RMLibraryViewController: UITableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }
    
    private func configure() {
        title = "Read Me Programmatically"
        tableView.rowHeight = 100
        tableView.register(RMAddNewBookTableViewCell.self, forCellReuseIdentifier: RMAddNewBookTableViewCell.reuseId)
        tableView.register(RMBookTableViewCell.self, forCellReuseIdentifier: RMBookTableViewCell.reuseId)
    }
    
    
}


extension RMLibraryViewController {
    
    // MARK: - UITableViewDelegate Methods -
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return section == 1 ? 60.0 : 0.0
    }

    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        switch section {
        case 0: return nil
        case 1: return RMLibraryHeaderView(reuseIdentifier: nil)
        default: fatalError("Uknown header view for unknow section.")
        }
    }
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        if indexPath == IndexPath(row: 0, section: 0) {
            let newBookTableViewController = RMNewBookTableViewController()
            navigationController?.pushViewController(newBookTableViewController, animated: true)
        } else {
            let detailTableViewController = RMDetailTableViewController(book: RMLibrary.books[indexPath.row])
            navigationController?.pushViewController(detailTableViewController, animated: true)
        }
    }
    
    // MARK: - UITableViewDatasource Methods -
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0: return 1
        case 1: return RMLibrary.books.count
        default: fatalError("Unknown number of rows for unknown section.")
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath == IndexPath(row: 0, section: 0) {
            return tableView.dequeueReusableCell(withIdentifier: RMAddNewBookTableViewCell.reuseId, for: indexPath)
        } else {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: RMBookTableViewCell.reuseId, for: indexPath) as? RMBookTableViewCell else { fatalError("Failed to dequeue reusable cell of type RMBookTableViewCell.") }
            
            let book = RMLibrary.books[indexPath.row]
            
            cell.titleLabel.text = book.title
            cell.authorLabel.text = book.author
            cell.bookThumbnailImageView.image = book.image
            return cell
        }
        
        
    }
}
