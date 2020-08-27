//
//  RMBookTableViewCell.swift
//  ReadMe App Storyboard
//
//  Created by Jason Pinlac on 8/27/20.
//  Copyright © 2020 Jason Pinlac. All rights reserved.
//

import UIKit

class RMBookTableViewCell: UITableViewCell {
    
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var authorLabel: UILabel!
    @IBOutlet var reviewLabel: UILabel!
    
    @IBOutlet var readMeBookmarkImageView: UIImageView!
    @IBOutlet var bookThumbnailImageView: UIImageView! {
        didSet {
            bookThumbnailImageView.layer.cornerRadius = 12
        }
    }
    
}
