//
//  PersistenceManager.swift
//  TaskList-UIKit
//
//  Created by Jason Pinlac on 7/4/20.
//  Copyright © 2020 Jason Pinlac. All rights reserved.
//

import Foundation


enum PersistenceManager {
    
    private static let key = "PrioritizedTasks"
    
    static func retrieveTasks() -> () {
        
        // if tasks don't exists create a new prioritized task array
        if let prioritizedTasksData = UserDefaults.standard.object(forKey: key) as? Data  {
            do {
                TaskBank.prioritizedTasks = try JSONDecoder().decode([[TaskItem]].self, from: prioritizedTasksData)
            } catch {
                print(error)
                print("Failed to decode priority tasks on retrieval")
            }
        } else {
            print("New prioritized task list created.")
            TaskBank.prioritizedTasks = [
                [],
                [],
                [],
            ]
        }
    }
    
    static func saveTasks() -> () {
        if let prioritizedTasksData = try? JSONEncoder().encode(TaskBank.prioritizedTasks) {
            UserDefaults.standard.set(prioritizedTasksData, forKey: key)
        } else {
            print("Failed to save taksts.")
        }
    }
    
}
