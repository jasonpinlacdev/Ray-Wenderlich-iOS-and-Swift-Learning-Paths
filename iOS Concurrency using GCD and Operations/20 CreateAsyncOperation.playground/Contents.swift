// Copyright (c) 2020 Razeware LLC
// For full license & permission details, see LICENSE.markdown.

import PlaygroundSupport
PlaygroundPage.current.needsIndefiniteExecution = true

import Foundation
//: # Create AsyncOperation
extension AsyncOperation {
  // TODO: Create State enum and keyPath
  enum State: String {
    case ready
    case executing
    case finished
    
    // add this var keyPath computed property that returns a string to match the base Operations state variables such as isReady, isExecuting, isFinished
    fileprivate var keyPath: String {
      return "is\(self.rawValue.capitalized)"
    }
  }
}

class AsyncOperation: Operation {
  // TODO: Create state management
  // here is the state property of type State enum. This property has property observers that use KVO to directly notify the base Operations state properties, IE, isExecuting, isFinished. Remember we have to do 2 KVO notifications for isExecuting and isFinished because the base Operation class doesn't have a single state property like our async operation subclass does. Instead it has multiple state properties that are get only of type boolean that we have to change and notify on when our operation state changes.
  var state: State = State.ready {
    willSet {
      willChangeValue(forKey: state.keyPath)
      willChangeValue(forKey: newValue.keyPath)
    }
    didSet {
      didChangeValue(forKey: state.keyPath)
      didChangeValue(forKey: oldValue.keyPath)
    }
  }
  
  // TODO: Override properties
  // we dont override isReady because apple's documentation says not to. The base class operation will decide when its actually ready based off of its dependencies.
  override var isExecuting: Bool { return state == .executing }
  override var isFinished: Bool { return state == .finished }
  
  // TODO: Override start
  override func start() {
    if isCancelled {
      state = .finished
      return
    }
    state = .executing
    main()
  }
  
  // override cancel
  override func cancel() {
    state = .finished
  }
}
/*:
 `AsyncSumOperation` simply adds two numbers together asynchronously and assigns the result. It sleeps for two seconds just so that you can
 see the random ordering of the operation.  Nothing guarantees that an operation will complete in the order it was added.
 */
class AsyncSumOperation: AsyncOperation {
  let rhs: Int
  let lhs: Int
  var result: Int?
  
  init(lhs: Int, rhs: Int) {
    self.lhs = lhs
    self.rhs = rhs
    
    super.init()
  }
  
  override func main() {
    DispatchQueue.global().async {
      Thread.sleep(forTimeInterval: 2)
      self.result = self.lhs + self.rhs
      // TODO: Set state to finished
      self.state = .finished
    }
  }
}
/*:
- important:
What would happen if you forgot to set `state` to `.finished`?
*/
//:
//: Now that you have an `AsyncOperation` base class and an `AsyncSumOperation` subclass, run it through a small test.
let queue = OperationQueue()
let pairs = [(2, 3), (5, 3), (1, 7), (12, 34), (99, 99)]

pairs.forEach { pair in
  // TODO: Create an AsyncSumOperation for pair

  let asyncSumOp = AsyncSumOperation(lhs: pair.0, rhs: pair.1)
  asyncSumOp.completionBlock = {
    guard let result = asyncSumOp.result else { return }
    print("\(asyncSumOp.lhs) + \(asyncSumOp.rhs) = \(result)")
  }

  // TODO: Add the operation to queue
  queue.addOperation(asyncSumOp)

}

// This prevents the playground from finishing prematurely.
// Never do this on a main UI thread!
queue.waitUntilAllOperationsAreFinished()
PlaygroundPage.current.finishExecution()
