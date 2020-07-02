//
//  TaskBank.swift
//  TaskList-UIKit
//
//  Created by Jason Pinlac on 6/25/20.
//  Copyright © 2020 Jason Pinlac. All rights reserved.
//

import UIKit

class TaskBank {
    
    static var tasks = [
               TaskItem(description: "wake up"),
               TaskItem(description: "turn on pc"),
               TaskItem(description: "DOTA"),
               TaskItem(description: "contracts"),
               TaskItem(description: "win games"),
               TaskItem(description: "brush teeth"),
               TaskItem(description: "eat"),
               TaskItem(description: "study"),
               TaskItem(description: "more study"),
               TaskItem(description: "break"),
               TaskItem(description: "eat"),
               TaskItem(description: "study"),
               TaskItem(description: "shower"),
               TaskItem(description: "dota"),
               TaskItem(description: "brush teeth"),
               TaskItem(description: "sleep"),
               TaskItem(description: "wake up 2"),
               TaskItem(description: "turn on pc 2"),
               TaskItem(description: "DOTA 2"),
               TaskItem(description: "contracts 2"),
               TaskItem(description: "win games 2"),
               TaskItem(description: "brush teeth 2"),
               TaskItem(description: "eat 2"),
               TaskItem(description: "study 2"),
               TaskItem(description: "more study 2"),
               TaskItem(description: "break 2"),
               TaskItem(description: "eat 2"),
               TaskItem(description: "study 2"),
               TaskItem(description: "shower 2"),
               TaskItem(description: "dota 2"),
               TaskItem(description: "brush teeth 2"),
               TaskItem(description: "sleep 2"),
    ]
    
    static func move(task: TaskItem, to index: Int) {
        guard let currentIndex = self.tasks.firstIndex(of: task) else {
            return
        }
        tasks.remove(at: currentIndex)
        tasks.insert(task, at: index)
    }
    
}
