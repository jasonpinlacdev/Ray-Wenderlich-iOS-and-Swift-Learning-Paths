//
//  RMBook.swift
//  Read Me App Programmatically
//
//  Created by Jason Pinlac on 8/23/20.
//  Copyright © 2020 Jason Pinlac. All rights reserved.
//

import UIKit

struct RMBook: Equatable, Hashable {
    
    static var mockBook = RMBook(title: "", author: "", review: "", readMe: false, image: nil)
    
    var title: String
    var author: String
    var review: String?
    var readMe: Bool
    var image: UIImage?
}

extension RMBook: Codable {
    enum CodingKeys: String, CodingKey {
        case title
        case author
        case review
        case readMe
    }
}
