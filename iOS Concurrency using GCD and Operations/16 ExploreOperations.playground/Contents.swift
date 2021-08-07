// Copyright (c) 2020 Razeware LLC
// For full license & permission details, see LICENSE.markdown.

import UIKit
import PlaygroundSupport
PlaygroundPage.current.needsIndefiniteExecution = true
//: # Explore Operations
//: An `Operation` represents a 'unit of work', and can be constructed as a `BlockOperation` or as a custom subclass of `Operation`.
//: ## BlockOperation
//: Create a `BlockOperation` to add two numbers
let operationQueue = OperationQueue()
var result: Int?


// TODO: Create and run sumOperation
let sumBlockOperation = BlockOperation {
  sleep(2)
  result = 3 + 2
}

sumBlockOperation.completionBlock = {
  print(result)
}

duration {
  operationQueue.addOperation(sumBlockOperation) // operationQueues run the operations work on background threads and async on the current thread.
//  sumBlockOperation.start() // calling start is a sync call on the current thread
}






//: Create a `BlockOperation` with multiple blocks:
// TODO: Create and run multiPrinter

let multiPrintBlockOperation = BlockOperation {
  sleep(2)
  print("Hello")
}

multiPrintBlockOperation.addExecutionBlock {
  sleep(2)
  print("my")
}

multiPrintBlockOperation.addExecutionBlock {
  sleep(2)
  print("name")
}

multiPrintBlockOperation.addExecutionBlock {
  sleep(2)
  print("is")
}

multiPrintBlockOperation.addExecutionBlock {
  sleep(2)
  print("Jason!")
}

duration {
  multiPrintBlockOperation.start() // this is a sync call
//  operationQueue.addOperation(multiPrintBlockOperation) // this is an async call
}



PlaygroundPage.current.finishExecution()
