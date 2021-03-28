//
//  RMBookDetailViewController.swift
//  ReadMe App UITableView
//
//  Created by Jason Pinlac on 2/4/21.
//

import UIKit
import PhotosUI

class RMBookDetailViewController: UITableViewController {
    
    var book: RMBook
    
    @IBOutlet var readMeButton: UIButton!
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var authorLabel: UILabel!
    @IBOutlet var imageView: UIImageView!
    @IBOutlet var reviewTextView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        readMeButton.setImage(book.readMe ? LibrarySymbol.bookmarkFill.image : LibrarySymbol.bookmark.image, for: .normal)
        titleLabel.text = book.title
        authorLabel.text = book.author
        imageView.layer.cornerRadius = 16
        imageView.image = book.image ?? LibrarySymbol.letterSquare(letter: titleLabel.text?.first).image
        reviewTextView.text = book.review
        reviewTextView.addDoneButton()
        reviewTextView.delegate = self
    }
    
    // required init?(coder:) means we are using interface builder/storyboards. Behind the scenes this decoder is needed to translate the storyboard implementations into code.
    
    // This init method is used in conjunction with the @IBSegueAction func showBookDetailView(coder:)
    init?(coder: NSCoder, book: RMBook) {
        self.book = book
        super.init(coder: coder)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented. Use init(coder:, book:) instead.")
    }
    
    @IBAction func toggleReadMe() {
        book.readMe.toggle()
        readMeButton.setImage(book.readMe ? LibrarySymbol.bookmarkFill.image : LibrarySymbol.bookmark.image, for: .normal)
    }
    
    @IBAction func updateBookImage(_ sender: Any) {
        let imagePicker = UIImagePickerController()
        imagePicker.allowsEditing = true
        imagePicker.delegate = self
        imagePicker.sourceType = UIImagePickerController.isSourceTypeAvailable(.camera) ? .camera : .photoLibrary
        present(imagePicker, animated: true)
    }
    
    @IBAction func saveChanges(_ sender: Any) {
        Library.update(book: book)
        navigationController?.popViewController(animated: true)
    }
    @IBAction func cancel(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
}


extension RMBookDetailViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let selectedImage = info[.editedImage] as? UIImage else { return }
        imageView.image = selectedImage
        book.image = selectedImage
        dismiss(animated: true)
    }
}

extension RMBookDetailViewController: UITextViewDelegate {
    func textViewDidEndEditing(_ textView: UITextView) {
        textView.resignFirstResponder()
        book.review = textView.text
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
