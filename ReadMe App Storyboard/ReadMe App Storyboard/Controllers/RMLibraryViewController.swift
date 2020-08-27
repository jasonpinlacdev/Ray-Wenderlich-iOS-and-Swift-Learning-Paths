//
//  ViewController.swift
//  ReadMe App Storyboard
//
//  Created by Jason Pinlac on 8/23/20.
//  Copyright © 2020 Jason Pinlac. All rights reserved.
//

import UIKit

class RMLibraryViewController: UITableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }
    
    @IBSegueAction func showDetailView(_ coder: NSCoder) -> RMDetailViewController? {
        guard let indexPath = tableView.indexPathForSelectedRow else { fatalError("Nothing selected!") }
        let book = RMLibrary.books[indexPath.row]
        return RMDetailViewController(coder: coder, book: book)
    }
    
    
}

extension RMLibraryViewController {
    
    // MARK: - DATASOURCE METHODS -
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return RMLibrary.books.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "RMBookTableViewCell", for: indexPath)
        let book = RMLibrary.books[indexPath.row]
        
        cell.textLabel?.text = book.title
        cell.imageView?.image = book.image
    
        return cell
    }
}

