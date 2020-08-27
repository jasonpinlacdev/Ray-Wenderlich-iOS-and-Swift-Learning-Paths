//
//  RMDetailViewController.swift
//  ReadMe App Storyboard
//
//  Created by Jason Pinlac on 8/26/20.
//  Copyright © 2020 Jason Pinlac. All rights reserved.
//

import UIKit

class RMDetailViewController: UIViewController {
    
    let book: RMBook
    
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var authorLabel: UILabel!
    @IBOutlet var bookThumbnailImageView: UIImageView!

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

     init?(coder: NSCoder, book: RMBook) {
        self.book = book
        super.init(coder: coder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUIElements()
    }
    
    @IBAction func updateImage() {
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.sourceType = UIImagePickerController.isSourceTypeAvailable(.camera) ? .camera : .photoLibrary
        picker.allowsEditing = true
        present(picker, animated: true)
    }
    
    private func configureUIElements() {
        titleLabel.text = book.title
        authorLabel.text = book.author
        bookThumbnailImageView.image = book.image
        bookThumbnailImageView.turnOnRedBorder()
    }

}

extension RMDetailViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let selectedImage = info[.editedImage] as? UIImage else { return }
        bookThumbnailImageView.image = selectedImage
        RMLibrary.saveImage(selectedImage, forBook: self.book)
        dismiss(animated: true)
    }
}
