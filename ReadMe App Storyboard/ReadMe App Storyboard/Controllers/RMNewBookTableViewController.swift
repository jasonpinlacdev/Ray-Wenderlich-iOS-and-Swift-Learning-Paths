//
//  RMNewBookTableViewController.swift
//  ReadMe App Storyboard
//
//  Created by Jason Pinlac on 8/31/20.
//  Copyright © 2020 Jason Pinlac. All rights reserved.
//

import UIKit

class RMNewBookTableViewController: UITableViewController {

    @IBOutlet var titleTextField: UITextField!
    @IBOutlet var authorTextField: UITextField!
    @IBOutlet var bookThumbnailImageView: UIImageView!
    
    @IBAction func addImage(_ sender: Any) {
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.allowsEditing = true
        picker.sourceType = UIImagePickerController.isSourceTypeAvailable(.camera) ? .camera : .photoLibrary
        present(picker, animated: true)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bookThumbnailImageView.layer.cornerRadius = 16
        bookThumbnailImageView.clipsToBounds = true
        titleTextField.addDoneButton()
        authorTextField.addDoneButton()
        titleTextField.delegate = self
        authorTextField.delegate = self
        
        let dismissKeyboardTap = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        tableView.addGestureRecognizer(dismissKeyboardTap)
    }
    
    @objc func dismissKeyboard() {
        tableView.endEditing(true)
    }
    
    
    
    

}

extension RMNewBookTableViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let selectedImage = info[.editedImage] as? UIImage else { return }
        bookThumbnailImageView?.image = selectedImage
        dismiss(animated: true)
    }
}

extension RMNewBookTableViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == titleTextField {
            return authorTextField.becomeFirstResponder()
        } else {
            return textField.resignFirstResponder()
        }
    }
}

extension UITextField {
    func addDoneButton() {
        let toolbar = UIToolbar(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
        toolbar.sizeToFit()
        toolbar.items = [
            UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil),
            UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(self.resignFirstResponder))
        ]
        self.inputAccessoryView = toolbar
    }
}
