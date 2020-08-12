//
//  DetailViewController.swift
//  UITableView Diffable Data Source
//
//  Created by Jason Pinlac on 7/31/20.
//  Copyright © 2020 Jason Pinlac. All rights reserved.
//

import UIKit

class DetailViewController: UITableViewController {
    
    var book: Book?
    
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var authorLabel: UILabel!
    @IBOutlet var imageView: UIImageView!
    @IBOutlet var reviewTextView: UITextView!
    @IBOutlet var readMeButton: UIButton!
    
    
    @IBAction func toggleReadMe() {
        book?.readMe.toggle()
        let image = book!.readMe ? LibrarySymbol.bookmarkFill.image : LibrarySymbol.bookmark.image
        readMeButton.setImage(image, for: .normal)
    }
    
    
    @IBAction func updateImage() {
        let imagePicker = UIImagePickerController()
        imagePicker.allowsEditing = true
        imagePicker.delegate = self
        imagePicker.sourceType = UIImagePickerController.isSourceTypeAvailable(.camera) ? .camera : .photoLibrary
        present(imagePicker, animated: true)
    }
    
    
    @objc func saveChanges(_ sender: UIBarButtonItem) {
         if reviewTextView.text != "Add your review here..." {
             book?.review = reviewTextView.text
         }
         Library.update(book: book!)
         navigationController?.popViewController(animated: true)
     }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureLayoutForBook()
        reviewTextView.addDoneButton()
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboardOnTap))
        tap.cancelsTouchesInView = true
        view.addGestureRecognizer(tap)
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(saveChanges(_:)))
    }
    
    
    private func configureLayoutForBook() {
        guard let book = book else { return }
        titleLabel.text = book.title
        authorLabel.text = book.author
        reviewTextView.text = book.review ?? "Add your review here..."
        
        imageView.image = book.image ?? LibrarySymbol.letterSquare(letter: book.title.first).image
        imageView.layer.cornerRadius = 16
        let image = book.readMe ? LibrarySymbol.bookmarkFill.image : LibrarySymbol.bookmark.image
        readMeButton.setImage(image, for: .normal)
    }
    
}


extension DetailViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let selectedImage = info[.editedImage] as? UIImage else { return }
        imageView.image = selectedImage
        book?.image = selectedImage
        dismiss(animated: true)
    }
}


extension DetailViewController: UITextViewDelegate {
    
    func textViewDidEndEditing(_ textView: UITextView) {
        textView.resignFirstResponder()
    }
    
    
    @objc func dismissKeyboardOnTap() {
        view.endEditing(true)
    }
}


extension UITextView {
    
    func addDoneButton() {
        let toolBar = UIToolbar()
        toolBar.sizeToFit()
        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(self.resignFirstResponder))
        toolBar.items = [flexibleSpace, doneButton]
        self.inputAccessoryView = toolBar
    }
}
