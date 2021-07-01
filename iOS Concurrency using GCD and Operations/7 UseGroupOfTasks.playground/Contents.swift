// Copyright (c) 2020 Razeware LLC
// For full license & permission details, see LICENSE.markdown.

import UIKit
import PlaygroundSupport
PlaygroundPage.current.needsIndefiniteExecution = true
//: # Use Group of Tasks
let userQueue = DispatchQueue.global(qos: .userInitiated)
let mainQueue = DispatchQueue.main
let numberArray = [(0,1), (2,3), (4,5), (6,7), (8,9)]

//: ## Creating a group
print("=== Group of sync tasks ===")
// TODO: Create slowAddGroup
let slowAddGroup = DispatchGroup()

//: ## Dispatching to a group
// TODO: Loop to add slowAdd tasks to group
for numberPair in numberArray {
  userQueue.async(group: slowAddGroup) {
    let res = slowAddPlus(numberPair)
    mainQueue.async {
      print(res)
    }
  }
}

//: ## Notification of group completion
//: Will be called only when every task in the dispatch group has completed
// TODO: Call notify method
slowAddGroup.notify(queue: mainQueue) {
  print("slowAdd group of tasks completed!")
}
