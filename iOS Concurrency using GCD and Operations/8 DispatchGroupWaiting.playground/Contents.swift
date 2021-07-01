// Copyright (c) 2020 Razeware LLC
// For full license & permission details, see LICENSE.markdown.

import UIKit
import PlaygroundSupport
PlaygroundPage.current.needsIndefiniteExecution = true
//: # DispatchGroup Waiting
//: You can make the current thread wait for a dispatch group to complete.
//:
//: __DANGER__ This is a synchronous call on the __current__ queue, so will block it. You cannot have anything in the group that needs to use the current queue, otherwise you'll deadlock.
let group = DispatchGroup()
let userQueue = DispatchQueue.global(qos: .userInitiated)

userQueue.async(group: group) {
  print("Start task 1")
  // TODO: Sleep for 4 seconds
  sleep(4)
  print("End task 1")
}

userQueue.async(group: group) {
  print("Start task 2")
  // TODO: Sleep for 1 second
  sleep(1)
  print("End task 2")
}

group.notify(queue: DispatchQueue.main) {
  // TODO: Announce completion, stop playground page
  print("Group of tasks. Task 1 and Task 2 completed.")
}
//: The tasks continue to run, even if the wait times out.
// TODO: Wait for 5 seconds, then for 3 seconds. Wait is a sync call and will block the current thread.
if group.wait(timeout: .now() + 3.0) == .timedOut {
  print("Group of tasks execution timed out after 3 seconds.")
} else {
  print("Group of tasks completed before the 3 second timeout.")
}

print("is this statement waiting to print on group.wait")



