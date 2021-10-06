//
//  BookDetailViewController.swift
//  ReadMe App UITableView with DataSource
//
//  Created by Jason Pinlac on 9/4/21.
//

import UIKit

class BookDetailTableViewController: UITableViewController {
  
  @IBOutlet var titleLabel: UILabel!
  @IBOutlet var authorLabel: UILabel!
  @IBOutlet var imageView: UIImageView!
  @IBOutlet var reviewTextView: UITextView!
  @IBOutlet var bookMarkButton: UIButton!
  
  var book: Book

  init?(coder: NSCoder, book: Book) {
    self.book = book
    super.init(coder: coder)
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    title = "Book Detail"
    titleLabel.text = book.title
    authorLabel.text = book.author
    reviewTextView.text = book.review ?? "No Review for this book yet..."
    reviewTextView.delegate = self
    reviewTextView.addDoneButton()
    imageView.image = book.image ?? LibrarySymbol.letterSquare(letter: book.title.first).image
    imageView.layer.cornerRadius = 16
    bookMarkButton.setImage((book.readMe ? LibrarySymbol.bookmarkFill.image : LibrarySymbol.bookmark.image), for: .normal)
  }

  
  @IBAction func toggleBookmark() {
    book.readMe = !book.readMe
    bookMarkButton.setImage((book.readMe ? LibrarySymbol.bookmarkFill.image : LibrarySymbol.bookmark.image), for: .normal)
  }
  
  
  @IBAction func updateBookImage() {
    let imagePickerController = UIImagePickerController()
    imagePickerController.delegate = self
    imagePickerController.sourceType = UIImagePickerController.isSourceTypeAvailable(.camera) ? .camera : .photoLibrary
    imagePickerController.allowsEditing = true
    present(imagePickerController, animated: true)
  }
  
  @IBAction func saveChanges() {
    Library.update(book: book)
    navigationController?.popViewController(animated: true)
  }
  
  
}

extension BookDetailTableViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
  func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
    guard let selectedImage = info[.editedImage] as? UIImage else { return }
    imageView.image = selectedImage
    book.image = selectedImage
    dismiss(animated: true, completion: nil)
  }
}

extension BookDetailTableViewController: UITextViewDelegate {
  func textViewDidEndEditing(_ textView: UITextView) {
    book.review = reviewTextView.text
  }
}

extension UITextView {
  func addDoneButton() {
    let toolbar = UIToolbar()
    toolbar.sizeToFit()
    let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
    let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(self.resignFirstResponder))
    toolbar.items = [flexSpace, doneButton]
    self.inputAccessoryView = toolbar
  }
}
