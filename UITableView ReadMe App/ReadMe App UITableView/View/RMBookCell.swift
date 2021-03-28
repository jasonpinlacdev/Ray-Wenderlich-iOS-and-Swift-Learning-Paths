//
//  RMBookCell.swift
//  ReadMe App UITableView
//
//  Created by Jason Pinlac on 2/9/21.
//

import UIKit

class RMBookCell: UITableViewCell {
    
    var book: RMBook? {
        didSet {
            titleLabel.text = book?.title
            authorLabel.text = book?.author
            thumbnailImageView.image = book?.image
        }
    }
    
    @IBOutlet private var titleLabel: UILabel!
    @IBOutlet private var authorLabel: UILabel!
    @IBOutlet private var reviewLabel: UILabel!
    @IBOutlet private var thumbnailImageView: UIImageView! {
        didSet {
            thumbnailImageView.layer.cornerRadius = 12
        }
    }
    @IBOutlet private var bookmarkImageView: UIImageView!


    
    
    
    
}


