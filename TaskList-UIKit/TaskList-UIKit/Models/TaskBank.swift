//
//  TaskBank.swift
//  TaskList-UIKit
//
//  Created by Jason Pinlac on 6/25/20.
//  Copyright © 2020 Jason Pinlac. All rights reserved.
//

import UIKit

enum TaskPriority: Int, CaseIterable, Codable {
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

class TaskItem: NSObject, Codable {
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
        ],
        
        // medium priority
        [
            TaskItem(description: "Play Dota", priority: .medium),
        ],
        
        // low priority
        [
            TaskItem(description: "Watch Naruto", priority: .low),
        ],
    ]
    
    static func move(task: TaskItem, from sourceIndex: IndexPath, to destinationIndex: IndexPath) {
        prioritizedTasks[sourceIndex.section].remove(at: sourceIndex.row)
        prioritizedTasks[destinationIndex.section].insert(task, at: destinationIndex.row)
        
    }
    
    static func move(task: TaskItem, from sourcePriority: TaskPriority, to destinationPriority: TaskPriority) {
        if let indexFound = prioritizedTasks[sourcePriority.rawValue].firstIndex(of: task) {
            prioritizedTasks[sourcePriority.rawValue].remove(at: indexFound)
            prioritizedTasks[destinationPriority.rawValue].insert(task, at: 0)
            PersistenceManager.saveTasks()
        }
    }
    
    static func deleteTask(at index: IndexPath) {
        TaskBank.prioritizedTasks[index.section].remove(at: index.row)
        PersistenceManager.saveTasks()
    }
    
    static func setCompletion(on task: TaskItem, complete: Bool) {
        task.isCompleted = complete
        PersistenceManager.saveTasks()
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
