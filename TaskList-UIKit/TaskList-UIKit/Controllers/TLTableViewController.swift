//
//  TLTableViewController.swift
//  TaskList-UIKit
//
//  Created by Jason Pinlac on 6/24/20.
//  Copyright © 2020 Jason Pinlac. All rights reserved.
//

import UIKit

class TLTableViewController: UITableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
        configureUIBarButtonItems()
    }
    
    
    func configureTableView() {
        navigationController?.navigationBar.prefersLargeTitles = true
        title = "Task List"
        tableView.register(TLTableViewCell.self, forCellReuseIdentifier: TLTableViewCell.reuseId)
//        tableView.allowsMultipleSelectionDuringEditing = true
    }
    
    
    func configureUIBarButtonItems() {
        let addButton = UIBarButtonItem(image: IconImage.add, style: .plain, target: self, action: #selector(addButtonTapped(_:)))
        let deleteButton = UIBarButtonItem(image: IconImage.delete, style: .plain, target: self, action: #selector(deleteButtonTapped(_:)))
        let editButton = UIBarButtonItem(image: IconImage.edit, style: .plain, target: self, action: #selector(editButtonTapped(_:)))
        
        self.navigationItem.rightBarButtonItem = addButton
        self.navigationItem.leftBarButtonItems = [editButton, deleteButton]
    }
    
    
    @objc func addButtonTapped(_ sender: UIBarButtonItem) {
        let createTaskViewController = TLCreateTaskViewController()
        createTaskViewController.delegate = self
        createTaskViewController.modalTransitionStyle = .crossDissolve
        createTaskViewController.modalPresentationStyle = .overFullScreen
        present(createTaskViewController, animated: true)
    }
    
    
    @objc func deleteButtonTapped(_ sender: UIBarButtonItem) {
        // deletes multiple selected tasks. For this to work we need to set tableView.allowsForMultipleSelectionDuringEditing property to true
        // also you need to add a guard statement in your tableView didSelectRowAt method to check if the tableView.isEditing is false
    }
    
    @objc func editButtonTapped(_ sender: UIBarButtonItem) {
        // toggles on/off editing mode for the table view
        tableView.setEditing(!tableView.isEditing, animated: true)
    }

}


extension TLTableViewController {
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return TaskBank.tasks.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: TLTableViewCell.reuseId, for: indexPath) as? TLTableViewCell else {
            fatalError("Failed to dequeue a reusable TLTableViewCell for index path.")
        }
        
        let task = TaskBank.tasks[indexPath.row]
        cell.accessoryType = .detailDisclosureButton
        
        if task.isCompleted {
            
            let attributes: [NSAttributedString.Key: Any] = [.strikethroughStyle: NSUnderlineStyle.single.rawValue]
            let attributedString = NSMutableAttributedString(string: task.textDescription, attributes: attributes)
            cell.textLabel?.text = nil
            cell.textLabel?.attributedText = attributedString
            
            cell.iconImageView.image = IconImage.checkmark
        } else if !task.isCompleted {
            
            cell.textLabel?.attributedText = nil
            cell.textLabel?.text = task.textDescription
            
            cell.iconImageView.image = IconImage.rectangle
        }
        
        return cell
    }
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard !tableView.isEditing else { return }
        if let cell = tableView.cellForRow(at: indexPath) as? TLTableViewCell  {
            let task = TaskBank.tasks[indexPath.row]
            
            if !task.isCompleted {
                
                let attributes: [NSAttributedString.Key: Any] = [.strikethroughStyle: NSUnderlineStyle.single.rawValue]
                let attributedString = NSMutableAttributedString(string: task.textDescription, attributes: attributes)
                cell.textLabel?.text = nil
                cell.textLabel?.attributedText = attributedString
                
                cell.iconImageView.image = IconImage.checkmark
                task.isCompleted = true
            } else if task.isCompleted {
                
                cell.textLabel?.attributedText = nil
                cell.textLabel?.text = task.textDescription
                
                cell.iconImageView.image = IconImage.rectangle
                task.isCompleted = false
            }
            
            tableView.deselectRow(at: indexPath, animated: true)
        }
    }
    
    
    
    override func tableView(_ tableView: UITableView, accessoryButtonTappedForRowWith indexPath: IndexPath) {
        let taskDetailViewController = TLTaskDetailViewController(task: TaskBank.tasks[indexPath.row])
        taskDetailViewController.delegate = self
        taskDetailViewController.modalTransitionStyle = .crossDissolve
        taskDetailViewController.modalPresentationStyle = .overFullScreen
        present(taskDetailViewController, animated: true)
    }
    
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            TaskBank.tasks.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .automatic)
        }
    }
    
    
    override func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        // enables moving the rows in editing mode. We just have to provide the functionality for keeping the model in sync with the view
        TaskBank.move(task: TaskBank.tasks[sourceIndexPath.row], to: destinationIndexPath.row)
    }
    
}


extension TLTableViewController: TLTaskDetailViewControllerDelegate {
    func didEditTask() {
        tableView.reloadData()
    }
}

extension TLTableViewController: TLCreateTaskViewControllerDelegate {
    func didCreateTask() {
        tableView.reloadData()
    }
}


