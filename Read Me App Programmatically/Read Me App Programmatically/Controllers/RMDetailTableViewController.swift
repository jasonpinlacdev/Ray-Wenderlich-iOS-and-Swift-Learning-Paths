//
//  RMDetailTableViewController.swift
//  Read Me App Programmatically
//
//  Created by Jason Pinlac on 8/29/20.
//  Copyright © 2020 Jason Pinlac. All rights reserved.
//

import UIKit

class RMDetailTableViewController: UITableViewController {
    
    var book: RMBook
    
    lazy var firstCell: RMFirstDetailTableViewCell = {
        let firstCell = RMFirstDetailTableViewCell(style: .default, reuseIdentifier: nil)
        firstCell.titleLabel.text = book.title
        firstCell.authorLabel.text = book.author
        return firstCell
    }()
    
    lazy var secondCell: RMSecondDetailTableViewCell = {
        let secondCell = RMSecondDetailTableViewCell(style: .default, reuseIdentifier: nil)
        secondCell.bookThumbnailImageView.image = book.image ?? RMLibrarySymbol.letterSquare(letter: book.title.first).image
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
        configureUIElements()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureTableView() {
        hidesBottomBarWhenPushed = true
        tableView.allowsSelection = false
        tableView.separatorStyle = .none
        tableView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(dismissKeyboardOnTap)))
    }
    
    private func configureUIElements() {
        thirdCell.reviewTextView.delegate = self
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(saveTapped))
         firstCell.bookmarkButton.setImage(book.readMe ? RMLibrarySymbol.bookmarkFill.image : RMLibrarySymbol.bookmark.image, for: .normal)
        firstCell.bookmarkButton.addTarget(self, action: #selector(toggleReadMeBookmark), for: .touchUpInside)
    }
    
    @objc func saveTapped() {
        RMLibrary.update(book: book)
        navigationController?.popViewController(animated: true)
    }
    
    @objc func toggleReadMeBookmark() {
        book.readMe.toggle()
        firstCell.bookmarkButton.setImage(book.readMe ? RMLibrarySymbol.bookmarkFill.image : RMLibrarySymbol.bookmark.image, for: .normal)
    }
    
    @objc func updateImage() {
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.sourceType = UIImagePickerController.isSourceTypeAvailable(.camera) ? .camera : .photoLibrary
        picker.allowsEditing = true
        present(picker, animated: true)
    }
    
    @objc func dismissKeyboardOnTap() {
        tableView.endEditing(true)
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
        book.image = selectedImage
        dismiss(animated: true)
    }
}

extension RMDetailTableViewController: UITextViewDelegate {
    func textViewDidEndEditing(_ textView: UITextView) {
        book.review = thirdCell.reviewTextView.text
    }
}
