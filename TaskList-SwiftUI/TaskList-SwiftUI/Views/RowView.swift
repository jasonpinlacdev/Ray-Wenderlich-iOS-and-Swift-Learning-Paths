//
//  RowView.swift
//  TaskList-SwiftUI
//
//  Created by Jason Pinlac on 6/16/20.
//  Copyright © 2020 Jason Pinlac. All rights reserved.
//

import SwiftUI

struct RowView: View {
    
    @Binding var task: Task
    
    let checkMark = Image(systemName: "checkmark")
    
    var body: some View {
        NavigationLink(destination: TaskEditingView(task: self.$task)) {
            if task.completed {
                checkMark
            } else {
                checkMark.hidden()
            }
            Text("\(task.name)").strikethrough(task.completed)
        }
    }
}

struct RowView_Previews: PreviewProvider {
    static var previews: some View {
        RowView(task: .constant( Task(name: "To Do") ) )
    }
}
