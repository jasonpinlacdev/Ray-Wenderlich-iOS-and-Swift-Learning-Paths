//
//  RMAddBookTableViewController.swift
//  Read Me App Programmatically
//
//  Created by Jason Pinlac on 8/31/20.
//  Copyright © 2020 Jason Pinlac. All rights reserved.
//

import UIKit

class RMNewBookTableViewController: UITableViewController {
    
    let firstCell = RMFirstNewBookTableViewCell(style: .default, reuseIdentifier: nil)
    let secondCell = RMSecondNewBookTableViewCell(style: .default, reuseIdentifier: nil)
    var newBookImage: UIImage?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
        configureUIElements()
    }
    
    private func configureTableView() {
        hidesBottomBarWhenPushed = true
        tableView.allowsSelection = false
        tableView.separatorStyle = .none
        tableView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(dismissKeyboardOnTap)))
    }
    
    private func configureUIElements() {
        let cancelButton = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(cancelTapped))
        let saveButton = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(saveTapped))
        
        navigationItem.leftBarButtonItem = cancelButton
        navigationItem.rightBarButtonItem = saveButton
        
        firstCell.titleTextField.addDoneButton()
        firstCell.authorTextField.addDoneButton()
        firstCell.titleTextField.delegate = self
        firstCell.authorTextField.delegate = self
        secondCell.updateImageButton.addTarget(self, action: #selector(addImage), for: .touchUpInside)
    }
    
    @objc func addImage() {
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.allowsEditing = true
        picker.sourceType = UIImagePickerController.isSourceTypeAvailable(.camera) ? .camera : .photoLibrary
        present(picker, animated: true)
    }
    
    @objc func dismissKeyboardOnTap() {
        tableView.endEditing(true)
    }
    
    @objc func saveTapped() {
        guard let title = firstCell.titleTextField.text, let author = firstCell.authorTextField.text, !title.isEmpty, !author.isEmpty else { return }
        RMLibrary.addNew(book: RMBook(title: title, author: author, review: nil, readMe: true, image: newBookImage))
        navigationController?.popViewController(animated: true)
    }
    
    @objc func cancelTapped() {
        navigationController?.popViewController(animated: true)
    }
    
    
}


extension RMNewBookTableViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        2
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
        case 0: return firstCell
        case 1: return secondCell
        default: fatalError("Unknown cell for unknown row")
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.row {
        case 0: return 120
        case 1: return 350
        default: fatalError("Unknown height for unknown row")
        }
    }
}

extension RMNewBookTableViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let selectedImage = info[.editedImage] as? UIImage else { return }
        secondCell.bookThumbnailImageView.image = selectedImage
        newBookImage = selectedImage
        dismiss(animated: true)
    }
}

extension RMNewBookTableViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == firstCell.titleTextField {
            return firstCell.authorTextField.becomeFirstResponder()
        } else {
            return textField.resignFirstResponder()
        }
    }
}
