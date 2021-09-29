//
//  AddNewBookViewController.swift
//  ReadMe App UITableView with DataSource
//
//  Created by Jason Pinlac on 9/5/21.
//

import UIKit

class AddNewBookViewController: UIViewController {
  
  @IBOutlet var bookTitleTextField: UITextField!
  @IBOutlet var bookAuthorTextField: UITextField!
  @IBOutlet var bookImageView: UIImageView!
  
  var newBookImage: UIImage?
  
  
  required init?(coder: NSCoder) {
    super.init(coder: coder)
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    title = "Add New Book"
    bookTitleTextField.addDoneButton(target: self.view, action: #selector(UIView.endEditing(_:)))
    bookAuthorTextField.addDoneButton(target: self.view, action: #selector(UIView.endEditing(_:)))
    let dismissKeyboardTapGestureRecognizer = UITapGestureRecognizer(target: self.view, action: #selector(UIView.endEditing(_:)))
    view.addGestureRecognizer(dismissKeyboardTapGestureRecognizer)
  }
  
  @IBAction func updateBookImage() {
    let imagePickerController = UIImagePickerController()
    imagePickerController.delegate = self
    imagePickerController.sourceType = UIImagePickerController.isSourceTypeAvailable(.camera) ? .camera : .photoLibrary
    imagePickerController.allowsEditing = true
    present(imagePickerController, animated: true)
  }
  
  @IBAction func saveNewBook() {
    guard let title = bookTitleTextField.text,
          let author = bookAuthorTextField.text,
          !title.isEmpty,
          !author.isEmpty
          else { return }
    Library.addNew(book: Book(title: title, author: author, review: nil, readMe: true, image: newBookImage))
    navigationController?.popViewController(animated: true)
  }
  
  
  @IBAction func cancel() {
    navigationController?.popViewController(animated: true)
  }
}


extension AddNewBookViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
  func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
    guard let selectedImage = info[.editedImage] as? UIImage else { return }
    bookImageView.image = selectedImage
    newBookImage = selectedImage
    dismiss(animated: true, completion: nil)
  }
}


extension UITextField {
  
  func addDoneButton(target: Any?, action: Selector?) {
    let toolBar = UIToolbar()
    toolBar.sizeToFit()
    let flexibleSpace = UIBarButtonItem(systemItem: .flexibleSpace)
    let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: target, action: action)
    toolBar.items = [flexibleSpace, doneButton]
    self.inputAccessoryView = toolBar
  }
  
}
