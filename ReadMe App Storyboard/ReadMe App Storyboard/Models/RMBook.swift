//
//  RMBook.swift
//  ReadMe App Storyboard
//
//  Created by Jason Pinlac on 8/23/20.
//  Copyright © 2020 Jason Pinlac. All rights reserved.
//

import UIKit

struct RMBook {
    var title: String
    var author: String
    var review: String?
    var image: UIImage {
        return RMLibrary.loadImage(forBook: self) ?? RMLibrarySymbol.letterSquare(letter: title.first).image
    }
}
