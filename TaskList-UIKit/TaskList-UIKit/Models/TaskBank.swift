//
//  TaskBank.swift
//  TaskList-UIKit
//
//  Created by Jason Pinlac on 6/25/20.
//  Copyright © 2020 Jason Pinlac. All rights reserved.
//

import UIKit

enum TaskPriority: Int, CaseIterable {
    case high
    case medium
    case low
    
    static func getStringName(for priority: TaskPriority) -> String {
        switch priority {
        case .high:
            return "High Priority"
        case .medium:
            return "Medium Priority"
        case .low:
            return "Low Priority"
        }
    }
}

class TaskItem: NSObject {
    var textDescription: String
    var priority: TaskPriority
    var isCompleted: Bool
    
    init(description: String, priority: TaskPriority) {
        self.textDescription = description
        self.priority = priority
        isCompleted = false
    }
}

class TaskBank {
    
    static var prioritizedTasks = [
        // high priority
        [
            TaskItem(description: "Code an app", priority: .high),
            TaskItem(description: "Study design patterns", priority: .high),
            TaskItem(description: "Talk to bae", priority: .high)
        ],
        
        // medium priority
        [
            TaskItem(description: "Play Dota", priority: .medium),
            TaskItem(description: "Train Capoeira", priority: .medium),
        ],
        
        // low priority
        [
            TaskItem(description: "Stretch", priority: .low),
            TaskItem(description: "Watch Naruto", priority: .low),
        ],
    ]
    
    static func move(task: TaskItem, to index: Int, of priority: TaskPriority) {
        guard let currentIndex = self.prioritizedTasks[task.priority.rawValue].firstIndex(of: task) else {
            return
        }
        prioritizedTasks[task.priority.rawValue].remove(at: currentIndex)
        prioritizedTasks[priority.rawValue].insert(task, at: index)
    }
    
    
    static func printTasks() {
        print("=== High Priority Model ===")
        prioritizedTasks[TaskPriority.high.rawValue].forEach { highTask in
            print("[\(highTask.textDescription), \(highTask.isCompleted), \(highTask.priority)]")
        }
        
        print("\n=== Medium Priority Model ===")
        prioritizedTasks[TaskPriority.medium.rawValue].forEach { mediumTask in
                  print("[\(mediumTask.textDescription), \(mediumTask.isCompleted), \(mediumTask.priority)]")
              }
        
        print("\n=== Low Priority Model ===")
        prioritizedTasks[TaskPriority.low.rawValue].forEach { lowTask in
                  print("[\(lowTask.textDescription), \(lowTask.isCompleted), \(lowTask.priority)]")
              }
        print("\n-------------------------------------------\n")
    }
    
}
