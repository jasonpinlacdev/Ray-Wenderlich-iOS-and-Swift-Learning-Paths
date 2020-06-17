//
//  TaskStore.swift
//  TaskList-SwiftUI
//
//  Created by Jason Pinlac on 6/16/20.
//  Copyright © 2020 Jason Pinlac. All rights reserved.
//

import Combine

class TaskStore: ObservableObject {
    
    struct PrioritizedTasks: Identifiable {
        var id: Task.Priority {
            priority
        }
        let priority: Task.Priority
        var tasks: [Task]
    }
    
    @Published var prioritizedTasks = [
        PrioritizedTasks(priority: .high, tasks: [
            "Shower and brush teeth",
            "Eat breakfast",
            "Complete the second SwiftUI App",
            "Start Programming in Swift: Functions and Types",
            ].map { Task(name: $0) }),
        
        PrioritizedTasks(priority: .medium, tasks: [
        "Take a break for some Dotes",
        "Finish Programming in Swift: Functions and Types",
        ].map { Task(name: $0) }),
        
        PrioritizedTasks(priority: .low, tasks: [
        "Have dinner",
               "Shower and brush teeth",
        ].map { Task(name: $0) }),
        
        PrioritizedTasks(priority: .none, tasks: [
       "Call bae",
        "Sleepy time",
        ].map { Task(name: $0) }),
        
    ]
    
    func getIndex(for priority: Task.Priority) -> Int {
        prioritizedTasks.firstIndex { $0.priority == priority }!
    }
    
}

