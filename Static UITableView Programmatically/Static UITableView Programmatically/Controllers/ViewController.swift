//
//  ViewController.swift
//  Static UITableView Programmatically
//
//  Created by Jason Pinlac on 8/29/20.
//  Copyright © 2020 Jason Pinlac. All rights reserved.
//

import UIKit

class ViewController: UITableViewController {
    
    var shareWithFriends = false
    
    let firstNameCell: FirstNameTableViewCell = {
        let firstNameCell = FirstNameTableViewCell()
        return firstNameCell
    }()
    
    let lastNameCell: LastNameTableViewCell = {
        let lastNameCell = LastNameTableViewCell()
        return lastNameCell
    }()
    
    let shareCell: UITableViewCell = {
        let shareCell = UITableViewCell()
        shareCell.textLabel?.text = "Share with Friends"
        shareCell.accessoryType = .checkmark
        shareCell.backgroundColor = .secondarySystemBackground
        return shareCell
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "User Options"
        tableView.separatorStyle = .none
        firstNameCell.firstNameTextField.delegate = self
        lastNameCell.lastNameTextField.delegate = self
    }
//    
}

extension ViewController {
    
    // MARK: - Section Methods -
    override func numberOfSections(in tableView: UITableView) -> Int {
        2
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case 0: return "Profile"
        case 1: return "Social"
        default: fatalError("Unknown section.")
        }
    }
    
    // MARK: - Row Methods -
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0: return 2
        case 1: return 1
        default: fatalError("Unknown number of sections.")
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            switch indexPath.row {
            case 0: return firstNameCell
            case 1: return lastNameCell
            default: fatalError("Unknown row in section 0.")
            }
        case 1:
            switch indexPath.row {
            case 0: return shareCell
            default: fatalError("Unknow row in section 1.")
            }
        default: fatalError("Unknown section.")
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath == IndexPath(row: 0, section: 1) {
            shareWithFriends.toggle()
            let cell = tableView.cellForRow(at: indexPath)
            
            if shareWithFriends {
                cell?.accessoryType = .checkmark
            } else {
                cell?.accessoryType = .none
            }
            tableView.deselectRow(at: indexPath, animated: true)
        }
    }
    
}


extension ViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}

