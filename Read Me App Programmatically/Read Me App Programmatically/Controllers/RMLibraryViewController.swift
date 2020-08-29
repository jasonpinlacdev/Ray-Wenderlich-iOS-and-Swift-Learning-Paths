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
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        if indexPath == IndexPath(row: 0, section: 0) { return }
        let detailViewController = RMDetailTableViewController(book: RMLibrary.books[indexPath.row - 1])
        navigationController?.pushViewController(detailViewController, animated: true)
    }
    
    // MARK: - UITableViewDatasource Methods -
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        RMLibrary.books.count + 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath == IndexPath(row: 0, section: 0) {
            return tableView.dequeueReusableCell(withIdentifier: RMAddNewBookTableViewCell.reuseId, for: indexPath)
        } else {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: RMBookTableViewCell.reuseId, for: indexPath) as? RMBookTableViewCell else { fatalError("Failed to dequeue reusable cell of type RMBookTableViewCell.") }
            
            let book = RMLibrary.books[indexPath.row - 1]
            
            cell.titleLabel.text = book.title
            cell.authorLabel.text = book.author
            cell.bookThumbnailImageView.image = book.image
            return cell
        }
        
        
    }
}
