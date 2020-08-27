//
//  RMBook.swift
//  Read Me App Programmatically
//
//  Created by Jason Pinlac on 8/23/20.
//  Copyright © 2020 Jason Pinlac. All rights reserved.
//

import UIKit

struct RMBook {
    var title: String
    var author: String
    var image: UIImage {
        return RMLibrary.loadImage(forBook: self) ?? RMLibrarySymbol.letterSquare(letter: self.title.first).image
    }
}
