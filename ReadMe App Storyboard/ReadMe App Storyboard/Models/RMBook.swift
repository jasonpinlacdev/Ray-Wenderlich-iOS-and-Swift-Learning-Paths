//
//  RMBook.swift
//  ReadMe App Storyboard
//
//  Created by Jason Pinlac on 8/23/20.
//  Copyright © 2020 Jason Pinlac. All rights reserved.
//

import UIKit

struct RMBook: Hashable, Equatable {
    
    static let mockBook = RMBook(title: "", author: "", readMe: false)
    
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
