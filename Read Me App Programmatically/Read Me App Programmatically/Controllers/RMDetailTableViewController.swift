//
//  RMDetailTableViewController.swift
//  Read Me App Programmatically
//
//  Created by Jason Pinlac on 8/29/20.
//  Copyright © 2020 Jason Pinlac. All rights reserved.
//

import UIKit

class RMDetailTableViewController: UITableViewController {
    
    let book: RMBook
    
    lazy var firstCell: RMFirstDetailTableViewCell = {
        let firstCell = RMFirstDetailTableViewCell(style: .default, reuseIdentifier: nil)
        firstCell.titleLabel.text = book.title
        firstCell.authorLabel.text = book.author
        return firstCell
    }()
    
    lazy var secondCell: RMSecondDetailTableViewCell = {
        let secondCell = RMSecondDetailTableViewCell(style: .default, reuseIdentifier: nil)
        secondCell.bookThumbnailImageView.image = book.image
        secondCell.updateImageButton.addTarget(self, action: #selector(updateImage), for: .touchUpInside)
        return secondCell
    }()
    
    lazy var thirdCell: RMThirdDetailTableViewCell = {
        let thirdCell = RMThirdDetailTableViewCell()
        if let review = book.review {
            thirdCell.reviewTextView.text = review
        }
        return thirdCell
    }()
    
    init(book: RMBook) {
        self.book = book
        super.init(nibName: nil, bundle: nil)
        configureTableView()
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        tableView.addGestureRecognizer(tapGesture)
    }
    
    @objc func dismissKeyboard() {
        tableView.endEditing(true)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func updateImage() {
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.sourceType = UIImagePickerController.isSourceTypeAvailable(.camera) ? .camera : .photoLibrary
        picker.allowsEditing = true
        present(picker, animated: true)
    }
    
    private func configureTableView() {
        tableView.allowsSelection = false
        tableView.separatorStyle = .none
    }
    
    
    
}

extension RMDetailTableViewController {
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.row {
        case 0: return 100
        case 1: return 350
        case 2: return 200
        default: fatalError("Unknown height for unknown row.")
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
        case 0: return firstCell
        case 1: return secondCell
        case 2: return thirdCell
        default: fatalError("Unknown cell for unknown row.")
        }
    }
}

extension RMDetailTableViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let selectedImage = info[.editedImage] as? UIImage else { return }
        secondCell.bookThumbnailImageView.image = selectedImage
        RMLibrary.saveImage(selectedImage, forBook: self.book)
        dismiss(animated: true)
    }
}
