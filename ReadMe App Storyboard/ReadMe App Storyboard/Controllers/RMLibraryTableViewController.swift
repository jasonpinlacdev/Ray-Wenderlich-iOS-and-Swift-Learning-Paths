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
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }
    
    @IBSegueAction func showDetailView(_ coder: NSCoder) -> RMDetailTableViewController? {
        guard let indexPath = tableView.indexPathForSelectedRow else { fatalError("Nothing selected!") }
        let book = RMLibrary.books[indexPath.row - 1]
        return RMDetailTableViewController(coder: coder, book: book)
    }
    
    
}

extension RMLibraryTableViewController {
    
    // MARK: - DATASOURCE METHODS -
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return RMLibrary.books.count + 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath == IndexPath(row: 0, section: 0) {
            let cell = tableView.dequeueReusableCell(withIdentifier: "RMAddNewBookTableViewCell", for: indexPath)
            return cell
        } else {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "\(RMBookTableViewCell.self)", for: indexPath) as? RMBookTableViewCell else { fatalError("Could not dequeue a reusable RMTableViewCell.") }
            let book = RMLibrary.books[indexPath.row - 1]
            
            cell.titleLabel?.text = book.title
            cell.authorLabel?.text = book.author
            cell.bookThumbnailImageView?.image = book.image
            
            return cell
        }
        
        
    }
}

