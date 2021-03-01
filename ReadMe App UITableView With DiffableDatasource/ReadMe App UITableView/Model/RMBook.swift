//
//  Book.swift
//  ReadMe App UITableView
//
//  Created by Jason Pinlac on 2/4/21.
//

import UIKit

struct RMBook: Hashable {
    static var mockBook = RMBook(title: "", author: "", review: nil, readMe: true, image: nil)

    let title: String
    let author: String
    var review: String?
    var readMe: Bool
    
    var image: UIImage?
}

//extension RMBook: Hashable {
//    func hash(into hasher: inout Hasher) {
//        hasher.combine(title)
//        hasher.combine(author)
//    }
//
//    static func ==(lhs: RMBook, rhs: RMBook) -> Bool {
//        lhs.title == rhs.title && lhs.author == rhs.author
//    }
//}


extension RMBook: Codable {
    enum CodingKeys: String, CodingKey {
        case title
        case author
        case review
        case readMe
    }
}
