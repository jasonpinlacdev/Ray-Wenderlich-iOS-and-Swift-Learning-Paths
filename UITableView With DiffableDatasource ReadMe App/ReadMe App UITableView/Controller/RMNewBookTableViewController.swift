//
//  RMNewBookTableViewController.swift
//  ReadMe App UITableView
//
//  Created by Jason Pinlac on 2/10/21.
//

import UIKit

class RMNewBookTableViewController: UITableViewController {
    
    var newBookImage: UIImage?
    
    @IBOutlet var titleTextField: UITextField!
    @IBOutlet var authorTextField: UITextField!
    @IBOutlet var imageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        titleTextField.returnKeyType = .done
        titleTextField.delegate = self
        titleTextField.addDoneButton()
        authorTextField.returnKeyType = .done
        authorTextField.delegate = self
        authorTextField.addDoneButton()
        imageView.layer.cornerRadius = 12
        view.addGestureRecognizer( UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard)))
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
        
    @IBAction func saveNewBook() {
        guard let title = titleTextField.text,
              let author = authorTextField.text,
              !title.isEmpty,
              !author.isEmpty
        else { return }
        
        let newBook = RMBook(title: title, author: author, review: nil, readMe: true, image: newBookImage)
        Library.addNew(book: newBook)
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func cancel() {
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func addImage(_ sender: Any) {
        let imagePicker = UIImagePickerController()
        imagePicker.allowsEditing = true
        imagePicker.delegate = self
        imagePicker.sourceType = UIImagePickerController.isSourceTypeAvailable(.camera) ? .camera : .photoLibrary
        present(imagePicker, animated: true)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
}

extension RMNewBookTableViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let selectedImage = info[.editedImage] as? UIImage else { return }
        imageView.image = selectedImage
        newBookImage = selectedImage
        dismiss(animated: true)
    }
}


extension RMNewBookTableViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
    }
}

extension UITextField {
    func addDoneButton() {
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(self.resignFirstResponder))
        toolbar.items = [flexSpace, doneButton]
        self.inputAccessoryView = toolbar
    }
}
