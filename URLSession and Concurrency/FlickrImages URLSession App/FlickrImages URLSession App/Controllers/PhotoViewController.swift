//
//  PhotoViewController.swift
//  FlickrImages URLSession App
//
//  Created by Jason Pinlac on 4/18/21.
//

import UIKit

class PhotoViewController: UIViewController {
  
  var photo: UIImage?
  var photoTitle: String?
  
  @IBOutlet var imageView: UIImageView!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    imageView.image = photo
    self.title = photoTitle
  }
  
}
