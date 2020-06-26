//
//  TLCreateTaskViewController.swift
//  TaskList-UIKit
//
//  Created by Jason Pinlac on 6/25/20.
//  Copyright © 2020 Jason Pinlac. All rights reserved.
//

import UIKit

protocol TLCreateTaskViewControllerDelegate {
    func createTaskTapped()
}


class TLCreateTaskViewController: UIViewController {
    
    var delegate: TLCreateTaskViewControllerDelegate?
    
    var containerView = TLContainerView(frame: .zero)
    var titleLabel = TLLabel(text: "Create Task")
    var textField = TLTextField(frame: .zero)
    
    var createButton: TLButton = {
        let button = TLButton(title: "Create", titleColor: .lightGray, buttonColor: .darkGray)
        button.addTarget(self, action: #selector(createButtonTapped(_:)), for: .touchUpInside)
        button.isEnabled = false
        return button
    }()
    
    var cancelButton: TLButton = {
        let button = TLButton(title: "Cancel", titleColor: .darkGray, buttonColor: .systemBlue)
        button.addTarget(self, action: #selector(cancelButtonTapped(_:)), for: .touchUpInside)
        return button
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        
        NotificationCenter.default.addObserver(self, selector: #selector(slideViewUpOnKeyboardAppearing(notification:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(slideViewDownOnKeyboardDisappearing(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil)
        
        textField.delegate = self
        textField.returnKeyType = .done
    }
    
    
    @objc func slideViewUpOnKeyboardAppearing(notification: NSNotification) {
        guard let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue else {
            return // if keyboard size is not available for some reason, dont do anything
        }
        var shouldMoveViewUp = false
        let bottomOfCreateContainer = containerView.convert(containerView.bounds, to: self.view).maxY;
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
    
    
    @objc func createButtonTapped(_ sender: TLButton?) {
        guard let text = textField.text, let empty = textField.text?.isEmpty, empty == false else { return }
        TaskBank.tasks.append(TaskItem(description: text))
        delegate?.createTaskTapped()
        textField.resignFirstResponder()
        dismiss(animated: true)
    }
    
    
    @objc func cancelButtonTapped(_ sender: TLButton) {
        dismiss(animated: true)
    }
    
    
    func configureUI() {
        view.backgroundColor = UIColor.systemBackground.withAlphaComponent(0.90)
        view.addSubview(containerView)
        
        NSLayoutConstraint.activate([
            containerView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            containerView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            containerView.widthAnchor.constraint(equalToConstant: 350),
            containerView.heightAnchor.constraint(equalToConstant: 350),
        ])
        
        containerView.addSubview(titleLabel)
        containerView.addSubview(textField)
        containerView.addSubview(createButton)
        containerView.addSubview(cancelButton)
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: containerView.topAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
            titleLabel.heightAnchor.constraint(equalToConstant: 50),
            
            textField.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 40),
            textField.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 40),
            textField.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -40),
            textField.heightAnchor.constraint(equalToConstant: 50),
            
            createButton.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -40),
            createButton.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -40),
            createButton.widthAnchor.constraint(equalToConstant: 75),
            createButton.heightAnchor.constraint(equalToConstant: 50),
            
            cancelButton.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 40),
            cancelButton.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -40),
            cancelButton.widthAnchor.constraint(equalToConstant: 75),
            cancelButton.heightAnchor.constraint(equalToConstant: 50),
        ])
        
        
    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
}


extension TLCreateTaskViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        createButtonTapped(nil)
        return true
    }
    
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard let oldText = textField.text, let stringRange = Range(range, in: oldText) else { return false }
        
        let newText = oldText.replacingCharacters(in: stringRange, with: string)
        if newText.isEmpty {
            createButton.isEnabled = false
            createButton.backgroundColor = .darkGray
            createButton.setTitleColor(.lightGray, for: .normal)
        } else {
            createButton.isEnabled = true
            createButton.backgroundColor = .systemBlue
            createButton.setTitleColor(.darkGray, for: .normal)
        }
        return true
    }
    
}
