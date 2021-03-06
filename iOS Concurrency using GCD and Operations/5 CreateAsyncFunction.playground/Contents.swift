// Copyright (c) 2020 Razeware LLC
// For full license & permission details, see LICENSE.markdown.

import UIKit
import PlaygroundSupport
PlaygroundPage.current.needsIndefiniteExecution = true
//: # Create Asynchronous Functions
//:
//: Global queues:
let userQueue = DispatchQueue.global(qos: .userInitiated)
let defaultQueue = DispatchQueue.global()
//: A slow synchronous function:
func slowAdd(_ input: (Int, Int)) -> Int {
  sleep(1)
  return input.0 + input.1
}
//: To use it only once, keep it simple:
// TODO: Dispatch slowAdd to userQueue
userQueue.async {
  let res = slowAdd((2,3))
  print(res)
}




//: You'll modify `slowAdd` to return a `Result` that's either an `Int`, or this specific error type, `Slow-add-error`:

enum SlowAddError: Error {
  case notEnoughFingers
}
//: Define `slowAddPlus` to return `Result` instead of `Int`.
//: Flip a coin to decide whether to return success or failure.
// TODO
func slowAddPlus(_ input: (Int, Int)) -> Result<Int, SlowAddError> {
  sleep(1)
  return Bool.random() ? Result.success(input.0 + input.1): Result.failure(.notEnoughFingers)
}
//: Check `slowAddPlus` works:
// TODO: Dispatch slowAddPlus on userQueue
userQueue.async {
let res = slowAddPlus((6,7))
print(res)
}

sleep(3)
// Comment out the next line before running the Reusable task exercise.
//PlaygroundPage.current.finishExecution()
//: ### 2. Reusable task
//: Wrap the `async` dispatch as an asynchronous function, with arguments for the input, queues and completion handler, and default values for the two queues.
//:
//: __Note:__ In an app, you would return to the main queue, but that doesn't work in playgrounds.
// TODO: Create asyncAdd function
func asyncAdd(_ input: (Int, Int),
  runQueue: DispatchQueue = DispatchQueue.global(qos: .userInitiated),
  completeQueue: DispatchQueue = DispatchQueue.main,
  completionHandler: @escaping (Result<Int, SlowAddError>) -> ()) {
  
  runQueue.async {
    let result = slowAddPlus(input)
    completeQueue.async {
      completionHandler(result)
    }
  }
  
}
//: Call `asyncAdd` with default queues. The completion handler
//: is in a trailing closure, and uses a `switch` block:
// TODO
asyncAdd((9,8)) { result in
  switch result {
  case .failure(let error):
    print(error)
  case .success(let sum):
    print(sum)
  }
}
PlaygroundPage.current.finishExecution()








