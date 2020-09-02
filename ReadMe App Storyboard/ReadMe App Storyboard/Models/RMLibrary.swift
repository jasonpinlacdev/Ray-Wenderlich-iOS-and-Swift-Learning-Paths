//
//  RMLibrary.swift
//  Read Me App Storyboard
//
//  Created by Jason Pinlac on 8/26/20.
//  Copyright © 2020 Jason Pinlac. All rights reserved.
//

import UIKit

enum RMLibrary {
   private static let starterData = [
        RMBook(title: "Ein Neues Land", author: "Shaun Tan", readMe: true),
        RMBook(title: "Bosch", author: "Laurinda Dixon", readMe: true),
        RMBook(title: "Dare to Lead", author: "Brené Brown", readMe: false),
        RMBook(title: "Blasting for Optimum Health Recipe Book", author: "NutriBullet", readMe:  false),
        RMBook(title: "Drinking with the Saints", author: "Michael P. Foley", readMe: true),
        RMBook(title: "A Guide to Tea", author: "Adagio Teas", readMe: false),
        RMBook(title: "The Life and Complete Work of Francisco Goya", author: "P. Gassier & J Wilson", readMe: true),
        RMBook(title: "Lady Cottington's Pressed Fairy Book", author: "Lady Cottington", readMe: false),
        RMBook(title: "How to Draw Cats", author: "Janet Rancan", readMe: true),
        RMBook(title: "Drawing People", author: "Barbara Bradley", readMe: false),
        RMBook(title: "What to Say When You Talk to Yourself", author: "Shad Helmstetter", readMe: true)
      ]
      
      static var books: [RMBook] = loadBooks()
      
      private static let booksJSONURL = URL(fileURLWithPath: "Books",
                                    relativeTo: FileManager.documentDirectoryURL).appendingPathExtension("json")
      
      
      /// This method loads all existing data from the `booksJSONURL`, if available. If not, it will fall back to using `starterData`
      /// - Returns: Returns an array of books, loaded from a JSON file
      private static func loadBooks() -> [RMBook] {
          let decoder = JSONDecoder()

          guard let booksData = try? Data(contentsOf: booksJSONURL) else {
            return starterData
          }

          do {
            let books = try decoder.decode([RMBook].self, from: booksData)
            return books.map { libraryBook in
              RMBook(
                title: libraryBook.title,
                author: libraryBook.author,
                review: libraryBook.review,
                readMe: libraryBook.readMe,
                image: loadImage(forBook: libraryBook)
              )
            }
            
          } catch let error {
            print(error)
            return starterData
          }
      }
      
      private static func saveAllBooks() {
        let encoder = JSONEncoder()
        encoder.outputFormatting = .prettyPrinted

        do {
          let booksData = try encoder.encode(books)
          try booksData.write(to: booksJSONURL, options: .atomicWrite)
        } catch let error {
          print(error)
        }
      }
      
      /// Adds a new book to the `books` array and saves it to disk.
      /// - Parameters:
      ///   - book: The book to be added to the library.
      ///   - image: An optional image to associate with the book.
      static func addNew(book: RMBook) {
        if let image = book.image { saveImage(image, forBook: book) }
        books.insert(book, at: 0)
        saveAllBooks()
      }
      
      
      /// Updates the stored value for a single book.
      /// - Parameter book: The book to be updated.
      static func update(book: RMBook) {
        if let newImage = book.image {
          saveImage(newImage, forBook: book)
        }
        
        guard let bookIndex = books.firstIndex(where: { storedBook in
          book.title == storedBook.title } )
        else {
            print("No book to update")
            return
        }
        
        books[bookIndex] = book
        saveAllBooks()
      }
      
      /// Removes a book from the `books` array.
      /// - Parameter book: The book to be deleted from the library.
      static func delete(book: RMBook) {
        guard let bookIndex = books.firstIndex(where: { storedBook in
          book == storedBook } )
          else { return }
      
        books.remove(at: bookIndex)
        
        let imageURL = FileManager.documentDirectoryURL.appendingPathComponent(book.title)
        do {
          try FileManager().removeItem(at: imageURL)
        } catch let error { print(error) }
        
        saveAllBooks()
      }
      
      static func reorderBooks(bookToMove: RMBook, bookAtDestination: RMBook) {
        let destinationIndex = RMLibrary.books.firstIndex(of: bookAtDestination) ?? 0
        books.removeAll(where: { $0.title == bookToMove.title })
        books.insert(bookToMove, at: destinationIndex)
        saveAllBooks()
      }
      
      /// Saves an image associated with a given book title.
      /// - Parameters:
      ///   - image: The image to be saved.
      ///   - title: The title of the book associated with the image.
      static func saveImage(_ image: UIImage, forBook book: RMBook) {
        let imageURL = FileManager.documentDirectoryURL.appendingPathComponent(book.title)
        if let jpgData = image.jpegData(compressionQuality: 0.7) {
          try? jpgData.write(to: imageURL, options: .atomicWrite)
        }
      }
      
      /// Loads and returns an image for a given book title.
      /// - Parameter title: Title of the book you need an image for.
      /// - Returns: The image associated with the given book title.
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
