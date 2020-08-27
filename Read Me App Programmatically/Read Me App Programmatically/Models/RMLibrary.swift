//
//  RMLibrary.swift
//  Read Me App Programmatically
//
//  Created by Jason Pinlac on 8/26/20.
//  Copyright © 2020 Jason Pinlac. All rights reserved.
//

import UIKit

enum RMLibrary {
    static let books: [RMBook] = [
        RMBook(title: "Ein Neues Land", author: "Shaun Tan"),
        RMBook(title: "Bosch", author: "Laurinda Dixon"),
        RMBook(title: "Dare to Lead", author: "Brené Brown"),
        RMBook(title: "Blasting for Optimum Health Recipe Book", author: "NutriBullet"),
        RMBook(title: "Drinking with the Saints", author: "Michael P. Foley"),
        RMBook(title: "A Guide to Tea", author: "Adagio Teas"),
        RMBook(title: "The Life and Complete Work of Francisco Goya", author: "P. Gassier & J Wilson"),
        RMBook(title: "Lady Cottington's Pressed Fairy Book", author: "Lady Cottington"),
        RMBook(title: "How to Draw Cats", author: "Janet Rancan"),
        RMBook(title: "Drawing People", author: "Barbara Bradley"),
        RMBook(title: "What to Say When You Talk to Yourself", author: "Shad Helmstetter")
    ]
    
    static func saveImage(_ image: UIImage, forBook book: RMBook) {
        let imageURL = FileManager.documentDirectoryURL.appendingPathComponent(book.title)
        if let jpgData = image.jpegData(compressionQuality: 0.7) {
            try? jpgData.write(to: imageURL, options: .atomicWrite)
        }
    }
    
    static func loadImage(forBook book: RMBook) -> UIImage? {
        let imageURL = FileManager.documentDirectoryURL.appendingPathComponent(book.title)
        return UIImage(contentsOfFile: imageURL.path)
    }
    
}

extension FileManager {
    static var documentDirectoryURL: URL {
        return `default`.urls(for: .documentDirectory, in: .userDomainMask)[0]
    }
}
