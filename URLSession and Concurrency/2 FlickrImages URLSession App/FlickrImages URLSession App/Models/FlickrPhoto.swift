//
//  FlickrPhoto.swift
//  FlickrImages URLSession App
//
//  Created by Jason Pinlac on 4/18/21.
//

import UIKit

struct FlickrPhoto {
  let title: String
  let image: UIImage
  let uuid: String = UUID().uuidString
}


extension FlickrPhoto: Hashable {
  static func ==(lhs: FlickrPhoto, rhs: FlickrPhoto) -> Bool {
    return lhs.title == rhs.title && lhs.image == rhs.image && lhs.uuid == rhs.uuid
  }
  
  func hash(into hasher: inout Hasher) {
    hasher.combine(title)
    hasher.combine(image)
    hasher.combine(uuid)
  }
}
