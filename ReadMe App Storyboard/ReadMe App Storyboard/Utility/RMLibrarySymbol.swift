//
//  RMLibrarySymbolImage.swift
//  ReadMe App Programmatically
//
//  Created by Jason Pinlac on 8/26/20.
//  Copyright © 2020 Jason Pinlac. All rights reserved.
//

import UIKit

enum RMLibrarySymbol {
    case book
    case bookmark
    case bookmarkFill
    case letterSquare(letter: Character?)
    
    var image: UIImage {
        let imageName: String
        
        switch self {
        case .book:
            imageName = "book"
        case .bookmark:
            imageName = "bookmark"
        case .bookmarkFill:
            imageName = "bookmark.fill"
        case .letterSquare(let letter):
            if let letter = letter?.lowercased() {
                imageName = "\(letter).square"
            } else {
                imageName = "square"
            }
        }
        
        return UIImage(systemName: imageName)!
    }
}
