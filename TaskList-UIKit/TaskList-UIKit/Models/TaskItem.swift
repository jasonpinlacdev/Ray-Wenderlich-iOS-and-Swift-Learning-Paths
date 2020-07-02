//
//  Task.swift
//  TaskList-UIKit
//
//  Created by Jason Pinlac on 6/24/20.
//  Copyright © 2020 Jason Pinlac. All rights reserved.
//

import Foundation

class TaskItem: NSObject {
    
    var textDescription: String
    var isCompleted: Bool
    
    init(description: String) {
        self.textDescription = description
        isCompleted = false
    }
}
