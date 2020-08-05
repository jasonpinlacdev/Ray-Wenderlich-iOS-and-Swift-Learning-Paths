//
//  ViewController.swift
//  UITableView Diffable Data Source
//
//  Created by Jason Pinlac on 7/30/20.
//  Copyright © 2020 Jason Pinlac. All rights reserved.
//

import UIKit

class LibraryViewController: UITableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }
    
}

extension LibraryViewController {
    
    // MARK: - TableView Delegate Methods -
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath == IndexPath(row: 0, section: 0) {
            print("Add new book")
        } else {
            guard let detailViewController = storyboard?.instantiateViewController(withIdentifier: "DetailViewController") as? DetailViewController else { return }
            detailViewController.book = Library.books[indexPath.row - 1]
            navigationController?.pushViewController(detailViewController, animated: true)
        }
    }
    
    
    // MARK: - Datasource Methods -
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Library.books.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath == IndexPath(row: 0, section: 0) {
            let cell = tableView.dequeueReusableCell(withIdentifier: "NewBookCell", for: indexPath)
            return cell
        } else {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "BookCell", for: indexPath) as? BookCell else { fatalError() }
            let book = Library.books[indexPath.row - 1]
            cell.titleLabel.text = book.title
            cell.authorLabel.text = book.author
            cell.bookThumbnail.image = book.image
            cell.bookThumbnail.layer.cornerRadius = 12
            
            
            return cell
        }
        
        
    }
}

