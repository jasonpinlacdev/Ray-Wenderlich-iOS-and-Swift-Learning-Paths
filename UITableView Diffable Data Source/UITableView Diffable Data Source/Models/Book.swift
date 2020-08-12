//
//  Book.swift
//  UITableView Diffable Data Source
//
//  Created by Jason Pinlac on 7/30/20.
//  Copyright © 2020 Jason Pinlac. All rights reserved.
//

import UIKit

struct Book: Hashable {
    
    static let mockBook = Book(title: "", author: "", readMe: true)
    
    let title: String
    let author: String
    var review: String?
    var readMe: Bool
    
    var image: UIImage?
}


extension Book: Codable {
    
    enum CodingKeys: String, CodingKey {
        case title
        case author
        case review
        case readMe
    }
}
