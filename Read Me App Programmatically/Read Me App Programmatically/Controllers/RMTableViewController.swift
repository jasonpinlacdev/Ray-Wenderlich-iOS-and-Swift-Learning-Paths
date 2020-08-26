//
//  ViewController.swift
//  Read Me App Programmatically
//
//  Created by Jason Pinlac on 8/23/20.
//  Copyright © 2020 Jason Pinlac. All rights reserved.
//

import UIKit

class RMTableViewController: UITableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }
    
    private func configure() {
        title = "Read Me Programmatically"
        tableView.register(RMBookTableViewCell.self, forCellReuseIdentifier: RMBookTableViewCell.reuseId)
    }
    
}


extension RMTableViewController {
    
    // MARK: - DATASOURCE METHODS -
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        RMLibrary.books.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: RMBookTableViewCell.reuseId, for: indexPath) as? RMBookTableViewCell else { fatalError() }
        
        var book = RMLibrary.books[indexPath.row]
        
        cell.textLabel?.text = book.title
        cell.imageView?.image = book.image
        
        return cell
    }
}
