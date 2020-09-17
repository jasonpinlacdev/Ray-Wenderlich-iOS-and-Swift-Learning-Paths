/// Copyright (c) 2019 Razeware LLC
/// 
/// Permission is hereby granted, free of charge, to any person obtaining a copy
/// of this software and associated documentation files (the "Software"), to deal
/// in the Software without restriction, including without limitation the rights
/// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
/// copies of the Software, and to permit persons to whom the Software is
/// furnished to do so, subject to the following conditions:
/// 
/// The above copyright notice and this permission notice shall be included in
/// all copies or substantial portions of the Software.
/// 
/// Notwithstanding the foregoing, you may not use, copy, modify, merge, publish,
/// distribute, sublicense, create a derivative work, and/or sell copies of the
/// Software in any work that is designed, intended, or marketed for pedagogical or
/// instructional purposes related to programming, coding, application development,
/// or information technology.  Permission for such use, copying, modification,
/// merger, publication, distribution, sublicensing, creation of derivative works,
/// or sale is expressly withheld.
/// 
/// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
/// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
/// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
/// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
/// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
/// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
/// THE SOFTWARE.

import Foundation
import Combine

class TaskStore: ObservableObject {    
    @Published var prioritizedTasks = [
        PrioritizedTasks(priority: .high, names: []),
        PrioritizedTasks(priority: .medium, names: []),
        PrioritizedTasks(priority: .low, names: []),
        PrioritizedTasks(priority: .no, names: []),
        ] {
        didSet {
//            saveJSONPrioritizedTasks()
            savePLISTPrioritizedTasks()
            
        }
    }
    
    let prioritizedTasksJSONURL = URL(fileURLWithPath: "PrioritizedTasks.json", relativeTo: FileManager.documentsDirectoryURL)
        let prioritizedTasksPLISTURL = URL(fileURLWithPath: "PrioritizedTasks.plist", relativeTo: FileManager.documentsDirectoryURL)
    
    init() {
        //        loadJSONPrioritizedTasks()
        loadPLISTPrioritizedTasks()
    }
    
    func getIndex(for priority: Task.Priority) -> Int {
        prioritizedTasks.firstIndex { $0.priority == priority }!
    }
    
    private func loadJSONPrioritizedTasks() {
        do {
            let decoder = JSONDecoder()
            let prioritizedTasksData = try Data(contentsOf: prioritizedTasksJSONURL)
            prioritizedTasks = try decoder.decode([TaskStore.PrioritizedTasks].self, from: prioritizedTasksData)
        } catch {
            print("Failed to load PrioritizedTask.json into Swift Data.\n",error)
        }
    }
    
    private func saveJSONPrioritizedTasks() {
        do {
            let encoder = JSONEncoder()
            encoder.outputFormatting = .prettyPrinted
            let prioritizedTasksData = try encoder.encode(prioritizedTasks)
            try prioritizedTasksData.write(to: prioritizedTasksJSONURL, options: .atomicWrite)
        } catch {
            print("Failed to save changes to prioritizedTasks into PrioritizedTasks.json.\n", error)
        }
    }
    
    private func loadPLISTPrioritizedTasks() {
        guard FileManager.default.fileExists(atPath: prioritizedTasksPLISTURL.path) else { return }
        
        do {
            let decoder = PropertyListDecoder()
            let prioritizedTasksData = try Data(contentsOf: prioritizedTasksPLISTURL)
            prioritizedTasks = try decoder.decode([TaskStore.PrioritizedTasks].self, from: prioritizedTasksData)
        } catch {
            print(error)
        }
        
    }
    
    private func savePLISTPrioritizedTasks() {
        do {
            let encoder = PropertyListEncoder()
            encoder.outputFormat = .xml
            let prioritizedTaskData = try encoder.encode(prioritizedTasks)
            try prioritizedTaskData.write(to: prioritizedTasksPLISTURL, options: .atomicWrite)
        } catch {
            print(error)
        }
    }
}

private extension TaskStore.PrioritizedTasks {
    init(priority: Task.Priority, names: [String]) {
        self.init(
            priority: priority,
            tasks: names.map { Task(name: $0) }
        )
    }
}
