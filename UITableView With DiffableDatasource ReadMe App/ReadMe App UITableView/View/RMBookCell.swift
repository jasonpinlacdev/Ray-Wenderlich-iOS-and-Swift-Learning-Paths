//
//  RMBookCell.swift
//  ReadMe App UITableView
//
//  Created by Jason Pinlac on 2/9/21.
//

import UIKit

class RMBookCell: UITableViewCell {
    
    static let reuseId: String = String(describing: RMBookCell.self)
    
    @IBOutlet private var titleLabel: UILabel!
    @IBOutlet private var authorLabel: UILabel!
    @IBOutlet private var reviewLabel: UILabel!
    @IBOutlet private var thumbnailImageView: UIImageView! {
        didSet {
            thumbnailImageView.layer.cornerRadius = 12
        }
    }
    @IBOutlet private var bookmarkImageView: UIImageView!
    
    func set(book: RMBook) {
        titleLabel.text = book.title
        authorLabel.text = book.author
        thumbnailImageView.image = book.image ?? LibrarySymbol.letterSquare(letter: titleLabel.text?.first).image
        if let review = book.review {
            reviewLabel.text = review
            reviewLabel.isHidden = false
        }
        bookmarkImageView.isHidden = !book.readMe
    }
    
}


