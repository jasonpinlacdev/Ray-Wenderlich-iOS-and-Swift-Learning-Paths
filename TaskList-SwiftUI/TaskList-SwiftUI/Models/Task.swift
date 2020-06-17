//
//  Task.swift
//  TaskList-SwiftUI
//
//  Created by Jason Pinlac on 6/16/20.
//  Copyright © 2020 Jason Pinlac. All rights reserved.
//

import Foundation

struct Task: Identifiable {
    
    enum Priority: String, CaseIterable {
        case high
        case medium
        case low
        case none
    }
    
    var id = UUID()
    var name: String
    var completed = false
    var priority: Priority = .none
}
