//
//  Book.swift
//  UITableView Diffable Data Source
//
//  Created by Jason Pinlac on 7/30/20.
//  Copyright © 2020 Jason Pinlac. All rights reserved.
//

import UIKit

struct Book {
    let title: String
    let author: String
    var image: UIImage {
        return Library.loadImage(forBook: self) ?? LibrarySymbol.letterSquare(letter: title.first).image
    }
}
