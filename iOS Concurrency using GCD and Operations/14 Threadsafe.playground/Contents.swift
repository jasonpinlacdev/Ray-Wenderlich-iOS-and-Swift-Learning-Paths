// Copyright (c) 2020 Razeware LLC
// For full license & permission details, see LICENSE.markdown.

import Foundation
import PlaygroundSupport
PlaygroundPage.current.needsIndefiniteExecution = true

open class Person {
  private var firstName: String
  private var lastName: String
  
  public init(firstName: String, lastName: String) {
    self.firstName = firstName
    self.lastName = lastName
  }
  
  open func changeName(firstName: String, lastName: String) {
    randomDelay(maxDuration:  0.2)
    self.firstName = firstName
    randomDelay(maxDuration:  1)
    self.lastName = lastName
  }
  
  open var name: String {
    get {
      return "\(firstName) \(lastName)"
    }
  }
  
}

func randomDelay(maxDuration: Double) {
  //  let randomWait = arc4random_uniform(UInt32(maxDuration * Double(USEC_PER_SEC)))
  let randomWait = UInt32.random(in: 0..<UInt32(maxDuration * Double(USEC_PER_SEC)))
  usleep(randomWait)
}
//: # Make a Class Threadsafe
//: ## The Problem: Race Condition
//: When you're using asynchronous calls then you need to consider thread safety.
//: Consider the following object:
let nameChangingPerson = Person(firstName: "Alison", lastName: "Anderson")
print(nameChangingPerson.name)
//: The `Person` class includes a method to change names:
nameChangingPerson.changeName(firstName: "Brian", lastName: "Biggles")
print(nameChangingPerson.name)
//: What happens if you try and use the `changeName(firstName:lastName:)` simulataneously from a concurrent queue?
let workerQueue = DispatchQueue(label: "com.raywenderlich.worker", attributes: .concurrent)
let nameChangeGroup = DispatchGroup()

let nameList = [("Charlie", "Cheesecake"), ("Delia", "Dingle"), ("Eva", "Evershed"), ("Freddie", "Frost"), ("Gina", "Gregory")]

// Comment out the code below before you implement ThreadSafePerson
for (idx, name) in nameList.enumerated() {
  workerQueue.async(group: nameChangeGroup) {
    usleep(UInt32(10_000 * idx))
    nameChangingPerson.changeName(firstName: name.0, lastName: name.1)
    print("Current Name: \(nameChangingPerson.name)")
  }
}

nameChangeGroup.notify(queue: DispatchQueue.global()) {
  print("Final name: \(nameChangingPerson.name)")
  PlaygroundPage.current.finishExecution()
}

// makes the current thread synchronously block until the group finishes its work
nameChangeGroup.wait()
//: __Result:__ `nameChangingPerson` has been left in an inconsistent state.
//:
//: ## The Solution: Dispatch Barrier for Thread Safety
//: A barrier allows you add a task to a concurrent queue that will be run in a serial fashion, i.e., it will wait for the currently queued tasks to complete, and prevent any new ones starting.
class ThreadSafePerson: Person {
  
  
}

print("\n=== Threadsafe ===")

let threadSafeNameGroup = DispatchGroup()

let threadSafePerson = ThreadSafePerson(firstName: "Anna", lastName: "Adams")

for (idx, name) in nameList.enumerated() {
  workerQueue.async(group: threadSafeNameGroup) {
    usleep(UInt32(10_000 * idx))
    threadSafePerson.changeName(firstName: name.0, lastName: name.1)
    print("Current threadsafe name: \(threadSafePerson.name)")
  }
}

threadSafeNameGroup.notify(queue: DispatchQueue.global()) {
  print("Final threadsafe name: \(threadSafePerson.name)")
  PlaygroundPage.current.finishExecution()
}
//: Now run the __TSanExample project__, to see Xcode's thread sanitizer find the race condition errors.
