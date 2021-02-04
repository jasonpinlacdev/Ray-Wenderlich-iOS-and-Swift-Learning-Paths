//
//  RMBookDetailViewController.swift
//  ReadMe App UITableView
//
//  Created by Jason Pinlac on 2/4/21.
//

import UIKit
import PhotosUI

class RMBookDetailViewController: UIViewController {
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var authorLabel: UILabel!
    @IBOutlet var bookImageView: UIImageView!
    
    var book: RMBook?

    override func viewDidLoad() {
        super.viewDidLoad()
        titleLabel.text = book?.title
        authorLabel.text = book?.author
        bookImageView.image = book?.image
    }
    
    @IBAction func updateBookImage(_ sender: Any) {
        let imagePicker = UIImagePickerController()
        imagePicker.allowsEditing = true
        imagePicker.delegate = self
        imagePicker.sourceType = UIImagePickerController.isSourceTypeAvailable(.camera) ? .camera : .photoLibrary
        present(imagePicker, animated: true)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
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
