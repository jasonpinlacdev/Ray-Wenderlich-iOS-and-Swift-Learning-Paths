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
    
    @IBAction func updateImage() {
        let imagePicker = UIImagePickerController()
        imagePicker.allowsEditing = true
        imagePicker.delegate = self
        imagePicker.sourceType = UIImagePickerController.isSourceTypeAvailable(.camera) ? .camera : .photoLibrary
        present(imagePicker, animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureLayoutForBook()
        reviewTextView.addDoneButton()
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboardOnTap))
        tap.cancelsTouchesInView = true
        view.addGestureRecognizer(tap)
        
    }
    
    @objc func dismissKeyboardOnTap() {
        view.endEditing(true)
    }
    
    private func configureLayoutForBook() {
        guard let book = book else { return }
        titleLabel.text = book.title
        authorLabel.text = book.author
        imageView.image = book.image
        
        if let reviewText = book.review {
            reviewTextView.text = reviewText
        }
        
        imageView.layer.cornerRadius = 16
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        guard let book = book else { return }
        guard let indexFound = Library.books.firstIndex(of: book) else { return }
        if reviewTextView.text != "Review..." {
            Library.books[indexFound].review = reviewTextView.text
        }
    }
    
}


extension DetailViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let selectedImage = info[.editedImage] as? UIImage else { return }
        imageView.image = selectedImage
        Library.saveImage(selectedImage, forBook: book!)
        dismiss(animated: true)
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
