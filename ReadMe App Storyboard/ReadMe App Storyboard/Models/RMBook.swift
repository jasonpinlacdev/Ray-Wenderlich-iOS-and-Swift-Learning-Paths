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
    lazy var image: UIImage = RMLibrarySymbolImage.letterSquare(letter: self.title.first).image
}
