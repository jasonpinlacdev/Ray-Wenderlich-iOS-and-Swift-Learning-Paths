//
//  Book.swift
//  ReadMe App UITableView
//
//  Created by Jason Pinlac on 2/4/21.
//

import UIKit

struct RMBook {
    static var mockBook = RMBook(title: "", author: "", review: nil, readMe: true, image: nil)

    let title: String
    let author: String
    var review: String?
    let readMe: Bool
    
    var image: UIImage?
}

extension RMBook: Hashable { }

extension RMBook: Codable {
    enum CodingKeys: String, CodingKey {
        case title
        case author
        case review
        case readMe
    }
}
