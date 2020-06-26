//
//  TLCreateTaskViewController.swift
//  TaskList-UIKit
//
//  Created by Jason Pinlac on 6/25/20.
//  Copyright © 2020 Jason Pinlac. All rights reserved.
//

import UIKit

class TLCreateTaskViewController: UIViewController {
    
    var createClosure: (() -> Void)?
    
    var creationContainerView: UIView = {
        let creationContainerView = UIView(frame: .zero)
        creationContainerView.translatesAutoresizingMaskIntoConstraints = false
        creationContainerView.backgroundColor = .systemGray6
        creationContainerView.layer.cornerRadius = 10
        creationContainerView.clipsToBounds = true
        creationContainerView.layer.borderColor = UIColor.systemGray5.cgColor
        creationContainerView.layer.borderWidth = 3
        return creationContainerView
    }()
    
    var textField: UITextField = {
        let textField = UITextField(frame: .zero)
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.placeholder = "Enter a task description..."
        textField.backgroundColor = .systemGray5
        textField.layer.cornerRadius = 10
        textField.layer.borderWidth = 3
        textField.layer.borderColor = UIColor.systemGray3.cgColor
        textField.textColor = .white
        textField.font = UIFont.systemFont(ofSize: 20)
        textField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 10))
        textField.leftViewMode = .always
        textField.rightView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 10))
        textField.rightViewMode = .always
        return textField
    }()
    
    
    var createButton: UIButton = {
        let createButton = UIButton(type: .system)
        createButton.translatesAutoresizingMaskIntoConstraints = false
        createButton.setTitle("Create", for: .normal)
        createButton.setTitleColor(.systemGray6, for: .normal)
        createButton.titleLabel?.font = UIFont.preferredFont(forTextStyle: .headline)
        createButton.backgroundColor = .systemGreen
        createButton.layer.borderColor = UIColor.systemGray3.cgColor
        createButton.layer.borderWidth = 3
        createButton.layer.cornerRadius = 10
        createButton.addTarget(self, action: #selector(createButtonTapped(_:)), for: .touchUpInside)
        return createButton
    }()
    
    var cancelButton: UIButton = {
        let cancelButton = UIButton(type: .system)
        cancelButton.translatesAutoresizingMaskIntoConstraints = false
        cancelButton.setTitle("Cancel", for: .normal)
        cancelButton.setTitleColor(.systemGray6, for: .normal)
        cancelButton.titleLabel?.font = UIFont.preferredFont(forTextStyle: .headline)
        cancelButton.backgroundColor = .systemRed
        cancelButton.layer.borderColor = UIColor.systemGray4.cgColor
        cancelButton.layer.borderWidth = 3
        cancelButton.layer.cornerRadius = 10
        cancelButton.addTarget(self, action: #selector(cancelButtonTapped(_:)), for: .touchUpInside)
        return cancelButton
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        
        NotificationCenter.default.addObserver(self, selector: #selector(slideViewUpOnKeyboardAppearing(notification:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(slideViewDownOnKeyboardDisappearing(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc func slideViewUpOnKeyboardAppearing(notification: NSNotification) {
        guard let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue else {
            return // if keyboard size is not available for some reason, dont do anything
        }
        var shouldMoveViewUp = false
        let bottomOfCreateContainer = creationContainerView.convert(creationContainerView.bounds, to: self.view).maxY;
        let topOfKeyboard = self.view.frame.height - keyboardSize.height
        
        // if the bottom of Textfield is below the top of keyboard, move up
        if bottomOfCreateContainer > topOfKeyboard {
            shouldMoveViewUp = true
        }
        
        if(shouldMoveViewUp) {
            self.view.frame.origin.y = 0 + topOfKeyboard - bottomOfCreateContainer - 40
        }
    }
    
    @objc func slideViewDownOnKeyboardDisappearing(notification: NSNotification) {
        // move back the root view origin to zero
        self.view.frame.origin.y = 0
    }
    
    
    @objc func createButtonTapped(_ sender: UIButton) {
        guard !(textField.text?.isEmpty)! else { return }
        guard let text = textField.text else { return }
        TaskBank.tasks.append(TaskItem(description: text))
        createClosure?()
        dismiss(animated: true)
    }
    
    
    @objc func cancelButtonTapped(_ sender: UIButton) {
        dismiss(animated: true)
    }
    
    func configureUI() {
        view.backgroundColor = UIColor.systemBackground.withAlphaComponent(0.90)
        view.addSubview(creationContainerView)
        
        NSLayoutConstraint.activate([
            creationContainerView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            creationContainerView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            creationContainerView.widthAnchor.constraint(equalToConstant: 350),
            creationContainerView.heightAnchor.constraint(equalToConstant: 350),
        ])
        
        creationContainerView.addSubview(textField)
        creationContainerView.addSubview(createButton)
        creationContainerView.addSubview(cancelButton)
        
        NSLayoutConstraint.activate([
            textField.topAnchor.constraint(equalTo: creationContainerView.topAnchor, constant: 40),
            textField.leadingAnchor.constraint(equalTo: creationContainerView.leadingAnchor, constant: 40),
            textField.trailingAnchor.constraint(equalTo: creationContainerView.trailingAnchor, constant: -40),
            textField.heightAnchor.constraint(equalToConstant: 50),
            
            createButton.trailingAnchor.constraint(equalTo: creationContainerView.trailingAnchor, constant: -40),
            createButton.bottomAnchor.constraint(equalTo: creationContainerView.bottomAnchor, constant: -40),
            createButton.widthAnchor.constraint(equalToConstant: 75),
            createButton.heightAnchor.constraint(equalToConstant: 50),
            
            cancelButton.leadingAnchor.constraint(equalTo: creationContainerView.leadingAnchor, constant: 40),
            cancelButton.bottomAnchor.constraint(equalTo: creationContainerView.bottomAnchor, constant: -40),
            cancelButton.widthAnchor.constraint(equalToConstant: 75),
            cancelButton.heightAnchor.constraint(equalToConstant: 50),
        ])
        
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
}
