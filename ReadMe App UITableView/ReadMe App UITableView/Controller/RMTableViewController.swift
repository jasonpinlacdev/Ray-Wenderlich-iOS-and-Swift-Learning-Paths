//
//  RMTableViewController.swift
//  ReadMe App UITableView
//
//  Created by Jason Pinlac on 2/4/21.
//

import UIKit

class RMTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Read Me Book Library"
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }

    @IBSegueAction func showBookDetailView(_ coder: NSCoder) -> RMBookDetailViewController? {
        guard let indexPath = tableView.indexPathForSelectedRow else { fatalError("Nothing selected.") }
        let book = Library.books[indexPath.row]
        return RMBookDetailViewController(coder: coder, book: book)
    }
}



// MARK: UITableViewDatasource
extension RMTableViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Library.books.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "BookCell", for: indexPath)
        let book = Library.books[indexPath.row]
        cell.textLabel?.text = book.title
        cell.detailTextLabel?.text = book.author
        cell.imageView?.image = book.image
        return cell
    }
}

// MARK: UITableViewDelegate
extension RMTableViewController {
    
}
