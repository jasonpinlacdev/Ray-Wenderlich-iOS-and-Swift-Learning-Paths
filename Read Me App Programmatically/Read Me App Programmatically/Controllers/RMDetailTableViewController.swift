//
//  RMDetailTableViewController.swift
//  Read Me App Programmatically
//
//  Created by Jason Pinlac on 8/28/20.
//  Copyright © 2020 Jason Pinlac. All rights reserved.
//

import UIKit

class RMDetailTableViewController: UITableViewController {
    
    var book: RMBook
    
    let cell1 = UITableViewCell(style: .default, reuseIdentifier: <#T##String?#>)
    let cell2 = UITableViewCell(style: .default, reuseIdentifier: <#T##String?#>)
    let cell3 = UITableViewCell(style: .default, reuseIdentifier: <#T##String?#>)
    
    
    let horizontalStackView: UIStackView = {
        let horizontalStackView = UIStackView()
        horizontalStackView.axis = .horizontal
        horizontalStackView.alignment = .center
        horizontalStackView.distribution = .fill
        horizontalStackView.spacing = 10.0
        horizontalStackView.translatesAutoresizingMaskIntoConstraints = false
        return horizontalStackView
    }()
    
    let verticalStackView: UIStackView = {
        let verticalStackView = UIStackView()
        verticalStackView.axis = .vertical
        verticalStackView.distribution = .fill
        verticalStackView.alignment = .fill
        return verticalStackView
    }()
    
    let bookmarkButton: UIButton = {
        let bookmarkButton = UIButton()
        return bookmarkButton
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
    
    let reviewTextView: UITextView = {
        let reviewTextView = UITextView()
        return reviewTextView
    }()
    
    init(book: RMBook) {
        self.book = book
        super.init(nibName: nil, bundle: nil)
        print("RMDetailTableViewController")
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUIElements()
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
        tableView.allowsSelection = false
        tableView.separatorStyle = .none
        
        titleLabel.text = self.book.title
        authorLabel.text = self.book.author
        bookThumbnailImageView.image = self.book.image
    }
    
    private func configureUILayout() {
        
    }
    
}

extension RMDetailTableViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let selectedImage = info[.editedImage] as? UIImage else { return }
        bookThumbnailImageView.image = selectedImage
        RMLibrary.saveImage(selectedImage, forBook: self.book)
        dismiss(animated: true)
    }
}
