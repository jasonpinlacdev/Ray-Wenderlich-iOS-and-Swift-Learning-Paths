// Copyright (c) 2020 Razeware LLC
// For full license & permission details, see LICENSE.markdown.

import Foundation
import PlaygroundSupport
PlaygroundPage.current.needsIndefiniteExecution = true

// TODO: Create queues with high and low qos values
let highPriorityQueue = DispatchQueue.global(qos: .userInteractive)
let mediumPriorityQueue = DispatchQueue.global(qos: .userInitiated)
let lowPriorityQueue = DispatchQueue.global(qos: .background)

// TODO: Create semaphore with value 1
let semaphore = DispatchSemaphore(value: 1)


// TODO: Dispatch task that sleeps before calling semaphore.wait()
highPriorityQueue.async {
  defer { semaphore.signal() }
  print("High priority task is now running.")
  print("High priority task is now asleep.")
  sleep(2)
  semaphore.wait()
  print("High Priority task is now finished.")
  PlaygroundPage.current.finishExecution()
}

for i in 1 ... 10 {
  mediumPriorityQueue.async {
    print("Running medium task \(i)")
    let waitTime = Double(Int.random(in: 0..<7))
    Thread.sleep(forTimeInterval: waitTime)
  }
}

// TODO: Dispatch task that takes a long time

lowPriorityQueue.async {
  defer { semaphore.signal() }
  semaphore.wait()
  print("Low priority task is now running.")
  print("Low priority task is now asleep.")
  sleep(5)
  print("Low priority task is now finished.")
}






