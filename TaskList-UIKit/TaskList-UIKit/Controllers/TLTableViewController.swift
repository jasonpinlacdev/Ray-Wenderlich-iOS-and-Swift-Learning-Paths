//
//  TLTableViewController.swift
//  TaskList-UIKit
//
//  Created by Jason Pinlac on 6/24/20.
//  Copyright © 2020 Jason Pinlac. All rights reserved.
//

import UIKit

class TLTableViewController: UITableViewController {
    
    var deleteButton: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        PersistenceManager.retrieveTasks()
        configureTableView()
        configureUIBarButtonItems()
        tableView.reloadData()
    }
    
    
    func configureTableView() {
        navigationController?.navigationBar.prefersLargeTitles = true
        title = "Task List"
        tableView.register(TLTableViewCell.self, forCellReuseIdentifier: TLTableViewCell.reuseId)
        tableView.allowsMultipleSelectionDuringEditing = true
        tableView.rowHeight = 44;
    }
    
    
    func configureUIBarButtonItems() {
        let addButton = UIBarButtonItem(image: IconImage.add, style: .plain, target: self, action: #selector(addButtonTapped(_:)))
        deleteButton = UIBarButtonItem(image: IconImage.delete, style: .plain, target: self, action: #selector(deleteButtonTapped(_:)))
        deleteButton.isEnabled = false
        deleteButton.tintColor = .systemRed
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
        // also you need to add a guard statement in your tableView didSelectRowAt method to check if the tableView.isEditing is false to fix the cell row tapped bug.
        
        if let selectedTaskIndexes = tableView.indexPathsForSelectedRows {
            // we have to remove in descending order because or else well get the index out of range error
            let descendingIndexes = selectedTaskIndexes.sorted { $0 > $1 }
            descendingIndexes.forEach { indexPath in
                TaskBank.deleteTask(at: indexPath)
            }
            tableView.beginUpdates()
            tableView.deleteRows(at: descendingIndexes, with: .fade)
            tableView.endUpdates()
        }
       
    }
    
    
    @objc func editButtonTapped(_ sender: UIBarButtonItem) {
        // toggles on/off editing mode for the table view
        tableView.setEditing(!tableView.isEditing, animated: true)
        deleteButton.isEnabled = tableView.isEditing
    }

}


extension TLTableViewController {
    
    // MARK: - METHODS FOR TABLEVIEW SECTIONS - Remember, the model always has to be in sync with the UI -
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        guard let priority = TaskPriority(rawValue: section) else { return "N/A" }
        let title = TaskPriority.getStringName(for: priority)
        return title
    }
    
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return TaskPriority.allCases.count
    }
    
    // MARK: - METHODS FOR TABLEVIEW ROWS -
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return TaskBank.prioritizedTasks[section].count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: TLTableViewCell.reuseId, for: indexPath) as? TLTableViewCell else {
            fatalError("Failed to dequeue a reusable TLTableViewCell for index path.")
        }
        
        let task = TaskBank.prioritizedTasks[indexPath.section][indexPath.row]
        cell.accessoryType = .detailDisclosureButton
        
        // this is to get rid of the bug of a cell having striked through text even if a task for the cell is not completed
        cell.textLabel?.attributedText = nil
        cell.textLabel?.text = task.textDescription
        
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
            let task = TaskBank.prioritizedTasks[indexPath.section][indexPath.row]
            
            if !task.isCompleted {
                
                let attributes: [NSAttributedString.Key: Any] = [.strikethroughStyle: NSUnderlineStyle.single.rawValue]
                let attributedString = NSMutableAttributedString(string: task.textDescription, attributes: attributes)
                cell.textLabel?.text = nil
                cell.textLabel?.attributedText = attributedString
                
                cell.iconImageView.image = IconImage.checkmark
                TaskBank.setCompletion(on: task, complete: true)
            } else if task.isCompleted {
                
                cell.textLabel?.attributedText = nil
                cell.textLabel?.text = task.textDescription
                
                cell.iconImageView.image = IconImage.rectangle
                TaskBank.setCompletion(on: task, complete: false)
            }
            tableView.deselectRow(at: indexPath, animated: true)
        }
    }
    
    
    
    override func tableView(_ tableView: UITableView, accessoryButtonTappedForRowWith indexPath: IndexPath) {
        let taskDetailViewController = TLTaskDetailViewController(task: TaskBank.prioritizedTasks[indexPath.section][indexPath.row])
        taskDetailViewController.delegate = self
        taskDetailViewController.modalTransitionStyle = .crossDissolve
        taskDetailViewController.modalPresentationStyle = .overFullScreen
        present(taskDetailViewController, animated: true)
    }
    
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            TaskBank.deleteTask(at: indexPath)
            tableView.beginUpdates()
            tableView.deleteRows(at: [indexPath], with: .automatic)
            tableView.endUpdates()
        }
    }
    
    
    override func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        guard destinationIndexPath.section < TaskBank.prioritizedTasks.count else { return }
        // enables moving the rows in editing mode. We just have to provide the functionality for keeping the model in sync with the view
        let task = TaskBank.prioritizedTasks[sourceIndexPath.section][sourceIndexPath.row]
        TaskBank.move(task: task, from: sourceIndexPath, to: destinationIndexPath)
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


