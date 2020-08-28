//
//  RMDetailViewController.swift
//  Read Me App Programmatically
//
//  Created by Jason Pinlac on 8/26/20.
//  Copyright © 2020 Jason Pinlac. All rights reserved.
//

import UIKit

class RMDetailViewController: UIViewController {
    
    var book: RMBook
    
    let verticalStack: UIStackView =  {
        let verticalStack = UIStackView()
        verticalStack.axis = .vertical
        verticalStack.distribution = .fill
        verticalStack.alignment = .fill
        verticalStack.spacing = 5.0
        verticalStack.translatesAutoresizingMaskIntoConstraints = false
        return verticalStack
    }()
    
    let titleLabel: UILabel = {
        let titleLabel = UILabel()
        titleLabel.text = "Title"
        titleLabel.font = UIFont.preferredFont(forTextStyle: .title1)
        titleLabel.numberOfLines = 0
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        return titleLabel
    }()
    
    let authorLabel: UILabel = {
        let authorLabel = UILabel()
        authorLabel.text = "Title"
        authorLabel.textColor = .secondaryLabel
        authorLabel.font = UIFont.preferredFont(forTextStyle: .title2)
        authorLabel.numberOfLines = 0
        authorLabel.translatesAutoresizingMaskIntoConstraints = false
        return authorLabel
    }()
    
    let bookThumbnailImageView: UIImageView = {
        let bookThumbnailImageView = UIImageView(image: RMLibrarySymbol.book.image)
        bookThumbnailImageView.translatesAutoresizingMaskIntoConstraints = false
        bookThumbnailImageView.contentMode = .scaleAspectFit
        bookThumbnailImageView.layer.cornerRadius = 16.0
        bookThumbnailImageView.clipsToBounds = true
        return bookThumbnailImageView
    }()
    
    let updateImageButton: UIButton = {
        let updateImageButton = UIButton(type: .system)
        updateImageButton.setTitle("Update Image", for: .normal)
        updateImageButton.titleLabel?.font = UIFont.preferredFont(forTextStyle: .body)
        updateImageButton.translatesAutoresizingMaskIntoConstraints = false
        updateImageButton.addTarget(self, action: #selector(updateImage), for: .touchUpInside)
        return updateImageButton
    }()
    
    init(book: RMBook) {
        self.book = book
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUIElements()
        configureUILayout()
    }
    
    @objc func updateImage() {
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.sourceType = UIImagePickerController.isSourceTypeAvailable(.camera) ? .camera : .photoLibrary
        picker.allowsEditing = true
        present(picker, animated: true)
    }
    
    private func configureUIElements() {
        view.backgroundColor = .systemBackground
        titleLabel.text = self.book.title
        authorLabel.text = self.book.author
        bookThumbnailImageView.image = self.book.image
    }
    
    private func configureUILayout() {
        verticalStack.addArrangedSubview(titleLabel)
        verticalStack.addArrangedSubview(authorLabel)
        verticalStack.addArrangedSubview(bookThumbnailImageView)
        verticalStack.addArrangedSubview(updateImageButton)
        view.addSubview(verticalStack)
    
        NSLayoutConstraint.activate([
            bookThumbnailImageView.heightAnchor.constraint(equalTo: bookThumbnailImageView.widthAnchor),
            verticalStack.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerYAnchor),
            verticalStack.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            verticalStack.widthAnchor.constraint(equalTo: view.safeAreaLayoutGuide.widthAnchor, multiplier: 0.8),
        ])
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

