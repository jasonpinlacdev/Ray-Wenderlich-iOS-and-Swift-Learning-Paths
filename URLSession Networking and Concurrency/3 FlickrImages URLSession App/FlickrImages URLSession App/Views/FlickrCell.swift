//
//  FlickrCell.swift
//  FlickrImages URLSession App
//
//  Created by Jason Pinlac on 4/18/21.
//

import UIKit

class FlickrCell: UITableViewCell {
  static let reuseId = String(describing: FlickrCell.self)
  
  @IBOutlet var flickrImageView: UIImageView!
  @IBOutlet var flickrTitleLabel: UILabel!
  
  override func awakeFromNib() {
    super.awakeFromNib()
    // Initialization code
    flickrImageView.layer.cornerRadius = 10
  }
  
  override func setSelected(_ selected: Bool, animated: Bool) {
    super.setSelected(selected, animated: animated)
    
    // Configure the view for the selected state
  }
  
}
