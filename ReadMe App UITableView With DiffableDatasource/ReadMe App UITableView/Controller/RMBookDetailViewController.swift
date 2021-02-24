//
//  RMBookDetailViewController.swift
//  ReadMe App UITableView
//
//  Created by Jason Pinlac on 2/4/21.
//

import UIKit
import PhotosUI

class RMBookDetailViewController: UITableViewController {
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var authorLabel: UILabel!
    @IBOutlet var bookImageView: UIImageView! {
        didSet {
            bookImageView.layer.cornerRadius = 16
        }
    }
    @IBOutlet var reviewTextView: UITextView!
    
    var book: RMBook?

    override func viewDidLoad() {
        super.viewDidLoad()
        titleLabel.text = book?.title
        authorLabel.text = book?.author
        bookImageView.image = book?.image ?? LibrarySymbol.letterSquare(letter: titleLabel.text?.first).image
        reviewTextView.text = book?.review
        reviewTextView.addDoneButton()
    }
    
    @IBAction func updateBookImage(_ sender: Any) {
        let imagePicker = UIImagePickerController()
        imagePicker.allowsEditing = true
        imagePicker.delegate = self
        imagePicker.sourceType = UIImagePickerController.isSourceTypeAvailable(.camera) ? .camera : .photoLibrary
        present(imagePicker, animated: true)
    }
    
    // required init?(coder:) means we are using interface builder/storyboards. Behind the scenes this decoder is needed to translate the storyboard implementations into code.
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    // This init method is used in conjunction with the @IBSegueAction func showBookDetailView(coder:)
    init?(coder: NSCoder, book: RMBook) {
        self.book = book
        super.init(coder: coder)
    }
    

    
}


extension RMBookDetailViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let selectedImage = info[.editedImage] as? UIImage else { return }
        bookImageView.image = selectedImage
        Library.saveImage(selectedImage, forBook: self.book!)
        dismiss(animated: true)
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
