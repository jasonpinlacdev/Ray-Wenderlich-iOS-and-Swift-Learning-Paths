//
//  NewBookViewController.swift
//  UITableView Diffable Data Source
//
//  Created by Jason Pinlac on 8/4/20.
//  Copyright © 2020 Jason Pinlac. All rights reserved.
//

import UIKit

class NewBookViewController: UITableViewController {
    
    @IBOutlet var titleTextField: UITextField!
    @IBOutlet var authorTextField: UITextField!
    @IBOutlet var imageView: UIImageView!

    @IBAction func addImage(_ sender: UIButton) {
        let imagePicker = UIImagePickerController()
        imagePicker.allowsEditing = true
        imagePicker.delegate = self
        imagePicker.sourceType = UIImagePickerController.isSourceTypeAvailable(.camera) ? .camera : .photoLibrary
        present(imagePicker, animated: true)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        imageView.layer.cornerRadius = 16
        titleTextField.delegate = self
        authorTextField.delegate = self
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboardOnTap))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboardOnTap() {
        view.endEditing(true)
    }
    
    
    

}

extension NewBookViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == titleTextField {
            return authorTextField.becomeFirstResponder()
        } else {
            return textField.resignFirstResponder()
        }
    }
}

extension  NewBookViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let selectedImage = info[.editedImage] as? UIImage else { return }
        imageView.image = selectedImage
        dismiss(animated: true)
    }
}


