// Copyright (c) 2020 Razeware LLC
// For full license & permission details, see LICENSE.markdown.

import UIKit
//: Specify indefinite execution to prevent the playground from killing background tasks when the "main" thread has completed.
import PlaygroundSupport
PlaygroundPage.current.needsIndefiniteExecution = true
//: # Use Dispatch Queues
//: ## Using a Global Queue
// TODO: Get the .userInitiated global dispatch queuey
let userInitiatedGlobalQueue = DispatchQueue.global(qos: .userInitiated)

// TODO: Get the .default global dispatch queue
let defaultGlobalQueue = DispatchQueue.global()

// TODO: Get the main queue
let mainQueue = DispatchQueue.main

//: Some simple tasks:
func task1() {
  print("Task 1 started")
  sleep(1)
  print("Task 1 finished")
}

func task2() {
  print("Task 2 started")
  print("Task 2 finished")
}

print("=== Starting userInitated global queue ===")
// TODO: Dispatch tasks onto the userInitated queue
duration {
    DispatchQueue.global(qos: .userInitiated).async {
        task1()
    }
    DispatchQueue.global(qos: .userInitiated).async {
        task2()
    }
}



sleep(2)
//: ## Using a Private Serial Queue
//: The only global serial queue is `DispatchQueue.main`, but you can create a private serial queue. Note that `.serial` is the default attribute for a private dispatch queue:
// TODO: Create mySerialQueue
let mySerialQueue = DispatchQueue(label: "dev.jasonpinlac.serial")

print("\n=== Starting mySerialQueue ===")
// TODO: Dispatch tasks onto mySerialQueue
duration {
    mySerialQueue.async {
        task1()
    }
    mySerialQueue.async {
        task2()
    }
}

sleep(2)
//: ## Creating a Private Concurrent Queue
//: To create a private __concurrent__ queue, specify the `.concurrent` attribute.
// TODO: Create workerQueue
let myConcurrentQueue = DispatchQueue(label: "dev.jasonpinlac.concurrent", attributes: .concurrent)

print("\n=== Starting myConcurrentQueue ===")
duration {
    myConcurrentQueue.async {
        task1()
    }
    myConcurrentQueue.async {
        task2()
    }
}


sleep(2)


//: ## Dispatching Work _Synchronously_
//: You have to be very careful calling a queue’s `sync` method because the _current_ thread has to wait until the task finishes running on the other queue. **Never** call sync on the **main** queue because that will deadlock your app!
//:
//: But sync is very useful for avoiding race conditions — if the queue is a serial queue, and it’s the only way to access an object, sync behaves as a _mutual exclusion lock_, guaranteeing consistent values.
//:
//: We can create a simple race condition by changing `value` asynchronously on a private queue, while displaying `value` on the current thread:
var value = 42

func changeValue() {
  sleep(1)
  value = 0
}
//: Run `changeValue()` asynchronously, and display `value` on the current thread
duration {
    mySerialQueue.async {
        changeValue()
    }
}

print(value)
sleep(3)
//: Now reset `value`, then run `changeValue()` __synchronously__, to block the current thread until the `changeValue` task has finished, thus removing the race condition:
// TODO
value = 42
duration {
    mySerialQueue.sync {
        changeValue()
    }
}
print(value)


// Allow time for sleeping tasks to finish before letting the playground finish execution:
sleep(3)
PlaygroundPage.current.finishExecution()