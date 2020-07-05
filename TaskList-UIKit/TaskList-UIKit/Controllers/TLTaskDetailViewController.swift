//
//  TLTaskViewController.swift
//  TaskList-UIKit
//
//  Created by Jason Pinlac on 6/25/20.
//  Copyright © 2020 Jason Pinlac. All rights reserved.
//

import UIKit

// setup communication between two view controllers using protol delegate pattern
protocol TLTaskDetailViewControllerDelegate {
    func didEditTask()
}

class TLTaskDetailViewController: UIViewController {
    
    var task: TaskItem
    var delegate: TLTaskDetailViewControllerDelegate?
    
    var containerView = TLContainerView(frame: .zero)
    var titleLabel = TLLabel(text: "Edit Task")
    var textField = TLTextField(frame: .zero)
    
    var editButton: TLButton = {
        let button = TLButton(title: "Edit", titleColor: .lightGray, buttonColor: .darkGray)
        button.addTarget(self, action: #selector(editButtonTapped(_:)), for: .touchUpInside)
        button.isEnabled = false
        return button
    }()
    
    var cancelButton: TLButton = {
        let button = TLButton(title: "Cancel", titleColor: .darkGray, buttonColor: .systemBlue)
        button.addTarget(self, action: #selector(cancelButtonTapped(_:)), for: .touchUpInside)
        return button
    }()
    
    
    init(task: TaskItem) {
        self.task = task
        super.init(nibName: nil, bundle: nil)
        textField.text = self.task.textDescription
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
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
    
    
    @objc func editButtonTapped(_ sender: TLButton?) {
        guard let text = textField.text, let empty = textField.text?.isEmpty, empty == false else { return }
        task.textDescription = text
        PersistenceManager.saveTasks()
        delegate?.didEditTask()
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
        containerView.addSubview(editButton)
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
            
            editButton.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -40),
            editButton.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -40),
            editButton.widthAnchor.constraint(equalToConstant: 75),
            editButton.heightAnchor.constraint(equalToConstant: 50),
            
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


extension TLTaskDetailViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        editButtonTapped(nil)
        return true
    }
    
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard let oldText = textField.text, let stringRange = Range(range, in: oldText) else { return false }
        
        let newText = oldText.replacingCharacters(in: stringRange, with: string)
        if newText.isEmpty {
            editButton.isEnabled = false
            editButton.backgroundColor = .darkGray
            editButton.setTitleColor(.lightGray, for: .normal)
        } else {
            editButton.isEnabled = true
            editButton.backgroundColor = .systemBlue
            editButton.setTitleColor(.darkGray, for: .normal)
        }
        return true
    }
    
}


