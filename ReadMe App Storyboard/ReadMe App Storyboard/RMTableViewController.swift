//
//  ViewController.swift
//  ReadMe App Storyboard
//
//  Created by Jason Pinlac on 8/23/20.
//  Copyright © 2020 Jason Pinlac. All rights reserved.
//

import UIKit

class RMTableViewController: UITableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    
}

extension RMTableViewController {
    
    // MARK: - DATASOURCE METHODS -
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return RMLibrary.books.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "RMBookTableViewCell", for: indexPath)
        var book = RMLibrary.books[indexPath.row]
        print(book)
        
        cell.textLabel?.text = book.title
        cell.imageView?.image = book.image
        
        
        return cell
    }
}

