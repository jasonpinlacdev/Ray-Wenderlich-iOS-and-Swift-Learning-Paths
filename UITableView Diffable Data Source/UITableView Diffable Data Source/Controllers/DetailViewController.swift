//
//  DetailViewController.swift
//  UITableView Diffable Data Source
//
//  Created by Jason Pinlac on 7/31/20.
//  Copyright © 2020 Jason Pinlac. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    
    var book: Book?
    
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var authorLabel: UILabel!
    @IBOutlet var imageView: UIImageView!
    
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
    }
    
    private func configureLayoutForBook() {
        guard let book = book else { return }
        titleLabel.text = book.title
        authorLabel.text = book.author
        imageView.image = book.image
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
