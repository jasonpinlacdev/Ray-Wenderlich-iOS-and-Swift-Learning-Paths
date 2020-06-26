//
//  TLTaskViewController.swift
//  TaskList-UIKit
//
//  Created by Jason Pinlac on 6/25/20.
//  Copyright © 2020 Jason Pinlac. All rights reserved.
//

import UIKit

// setup communication between two view controllers using protol delegate pattern
protocol TLTaskViewControllerDelegate {
    func taskViewSaveTapped()
}

class TLTaskDetailViewController: UIViewController {
    
    var task: TaskItem
    var atIndexPath: IndexPath
    
    var delegate: TLTaskViewControllerDelegate?
    
    var textField: UITextField = {
        var textField = UITextField(frame: .zero)
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.placeholder = "Task to edit"
        return textField
    }()
    
    init(task: TaskItem, atIndexPath: IndexPath) {
        self.task = task
        self.atIndexPath = atIndexPath
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        layoutUI()
        configure()
    }
    
    func configure() {
        title = "Edit Task"
        textField.text = task.description
        navigationItem.largeTitleDisplayMode = .never
        view.backgroundColor = .systemBackground
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Save", style: .plain, target: self, action: #selector(saveButtonTapped(_:)))
    }
    
    
    func layoutUI() {
        self.view.addSubview(textField)
        
        NSLayoutConstraint.activate([
            textField.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            textField.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor, constant: 10),
            textField.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor, constant: 10),
            textField.heightAnchor.constraint(equalToConstant: 100),
        ])
    }
    
    
    @objc func saveButtonTapped(_ sender: UIBarButtonItem) {
        task.description = textField.text!
        delegate?.taskViewSaveTapped()
        navigationController?.popViewController(animated: true)
    }
    
    
    
}
