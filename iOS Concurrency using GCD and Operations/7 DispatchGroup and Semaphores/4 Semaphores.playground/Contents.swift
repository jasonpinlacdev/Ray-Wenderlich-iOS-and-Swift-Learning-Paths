// Copyright (c) 2020 Razeware LLC
// For full license & permission details, see LICENSE.markdown.

import UIKit
import PlaygroundSupport
PlaygroundPage.current.needsIndefiniteExecution = true
//: # DispatchSemaphore
//let group = DispatchGroup()
//let queue = DispatchQueue.global(qos: .userInteractive)

// TODO: Create a semaphore that allows four concurrent accesses
//let semaphore = DispatchSemaphore(value: 2)

// TODO: Simulate downloading group of images

//let urls = [1,2,3,4,5,6,7,8,9,10]
//
//urls.forEach { url in
//  queue.async(group: group) {
//    semaphore.wait()
//    defer { semaphore.signal() }
//    print("download started for image at url \(url).")
//    Thread.sleep(forTimeInterval: 4.0)
//    print("download completed for image at url \(url).")
//  }
//}


//group.notify(queue: DispatchQueue.main) {
//  print("All tasks in the group completed!")
//}






let queue = DispatchQueue.global(qos: .userInteractive)
let group = DispatchGroup()
let semaphore = DispatchSemaphore(value: 4)

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
    // TODO: signal the semaphore after leaving the group
    defer {
      group.leave()
      semaphore.signal()
    }
    
    completionHandler(data, response, error)
  }.resume()
}

for id in ids {
  guard let url = URL(string: "\(base)\(id)-jpeg.jpg") else { continue }
  // TODO: Call dataTask_Group_Semaphore
  dataTask_Group_Semaphore(with: url, group: group, semaphore: semaphore) { data, response, error in
    guard error == nil,
          let data = data,
          let image = UIImage(data: data)
          else { return }
    images.append(image)
  }
}

group.notify(queue: queue) {
  print("All done!")
  images
  PlaygroundPage.current.finishExecution()
}
