// Copyright (c) 2020 Razeware LLC
// For full license & permission details, see LICENSE.markdown.

import UIKit
import PlaygroundSupport
PlaygroundPage.current.needsIndefiniteExecution = true
//: # DispatchSemaphore
let group = DispatchGroup()
let queue = DispatchQueue.global(qos: .userInteractive)
// TODO: Create a semaphore that allows four concurrent accesses
let semaphore = DispatchSemaphore(value: 4)

// TODO: Simulate downloading group of images

for i in 1...10 {

  queue.async(group: group) {
    defer { semaphore.signal() }
    semaphore.wait()
    print("Download for image \(i) started.")
    Thread.sleep(forTimeInterval: 3.0)
    print("Download for image \(i) completed.")
  }
}







// Really download group of images
let base = "https://wolverine.raywenderlich.com/books/con/image-from-rawpixel-id-"
let ids = [466881, 466910, 466925, 466931, 466978, 467028, 467032, 467042, 467052]
var images: [UIImage] = []

// TODO: Add semaphore argument to dataTask_Group
func dataTask_Group_Semaphore(with url: URL,
                              group: DispatchGroup,
                              semaphore: DispatchSemaphore,
                              completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) {
  // TODO: wait for semaphore before entering group
  semaphore.wait()
  group.enter()
  URLSession.shared.dataTask(with: url) { data, response, error in
    defer { group.leave(); semaphore.signal() }
    completionHandler(data, response, error)
  }.resume()
}

for id in ids {
  guard let url = URL(string: "\(base)\(id)-jpeg.jpg") else { continue }
  // TODO: Call dataTask_Group_Semaphore
  dataTask_Group_Semaphore(with: url, group: group, semaphore: semaphore) { (data, response, error) -> () in
    guard error == nil else { return }
    guard let data = data else { return }
    guard let image = UIImage(data: data) else { return }
    images.append(image)
    print(image)
  }
}

group.notify(queue: queue) {
  print("All done!")
  images[0]
  PlaygroundPage.current.finishExecution()
}
