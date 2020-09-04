//
//  RMDetailViewController.swift
//  ReadMe App Storyboard
//
//  Created by Jason Pinlac on 8/26/20.
//  Copyright © 2020 Jason Pinlac. All rights reserved.
//

import UIKit

class RMDetailTableViewController: UITableViewController {
    
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var authorLabel: UILabel!
    @IBOutlet var reviewTextView: UITextView!
    @IBOutlet var bookmarkButton: UIButton!
    @IBOutlet var bookThumbnailImageView: UIImageView!
    
    @IBAction func saveBookChanges() {
        RMLibrary.update(book: book)
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func toggleReadMeBookmarkButton(_ sender: UIButton) {
        book.readMe.toggle()
        sender.setImage(book.readMe ? RMLibrarySymbol.bookmarkFill.image : RMLibrarySymbol.bookmark.image, for: .normal)
    }
    
    
    var book: RMBook

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

     init?(coder: NSCoder, book: RMBook) {
        self.book = book
        super.init(coder: coder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUIElements()
        
    }
    
    @IBAction func updateImage() {
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.sourceType = UIImagePickerController.isSourceTypeAvailable(.camera) ? .camera : .photoLibrary
        picker.allowsEditing = true
        present(picker, animated: true)
    }
    
    private func configureUIElements() {
        tableView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard)))
        
        bookmarkButton.setImage(book.readMe ? RMLibrarySymbol.bookmarkFill.image : RMLibrarySymbol.bookmark.image, for: .normal)
        titleLabel.text = book.title
        authorLabel.text = book.author
        bookThumbnailImageView.image = book.image ?? RMLibrarySymbol.letterSquare(letter: book.title.first).image
        bookThumbnailImageView.layer.cornerRadius = 16
        if let reviewText = book.review {
            reviewTextView.text = reviewText
        }
        reviewTextView.delegate = self
        reviewTextView.addDoneButton()
    }
    
    @objc func dismissKeyboard() {
        tableView.endEditing(true)
    }

}

extension RMDetailTableViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let selectedImage = info[.editedImage] as? UIImage else { return }
        bookThumbnailImageView.image = selectedImage
        book.image = selectedImage
        dismiss(animated: true)
    }
}

extension RMDetailTableViewController: UITextViewDelegate {
    func textViewDidEndEditing(_ textView: UITextView) {
        book.review = reviewTextView.text
        reviewTextView.resignFirstResponder()
    }
}


