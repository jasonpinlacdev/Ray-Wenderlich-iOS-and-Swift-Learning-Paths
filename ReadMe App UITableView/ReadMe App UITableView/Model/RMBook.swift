//
//  Book.swift
//  ReadMe App UITableView
//
//  Created by Jason Pinlac on 2/4/21.
//

import UIKit

struct RMBook {
    let title: String
    let author: String
    
    var image: UIImage {
        Library.loadImage(forBook: self) ?? LibrarySymbol.letterSquare(letter: self.title.first!).image
    }
}
