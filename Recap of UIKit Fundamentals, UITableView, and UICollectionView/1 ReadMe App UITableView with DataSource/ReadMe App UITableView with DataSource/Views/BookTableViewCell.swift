//
//  BookTableViewCell.swift
//  ReadMe App UITableView with DataSource
//
//  Created by Jason Pinlac on 9/5/21.
//

import UIKit

class BookTableViewCell: UITableViewCell {

  @IBOutlet var bookImageView: UIImageView!
  @IBOutlet var titleLable: UILabel!
  @IBOutlet var authorLabel: UILabel!
  @IBOutlet var reviewLabel: UILabel!
  @IBOutlet var bookMarkImageView: UIImageView!
  
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }

}
