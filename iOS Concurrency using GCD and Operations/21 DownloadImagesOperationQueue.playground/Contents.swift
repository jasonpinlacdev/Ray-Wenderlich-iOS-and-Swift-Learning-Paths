// Copyright (c) 2020 Razeware LLC
// For full license & permission details, see LICENSE.markdown.

import UIKit
import PlaygroundSupport
PlaygroundPage.current.needsIndefiniteExecution = true
//: # Downloading Images in an OperationQueue
//: Subclass `AsyncOperation` to create an operation that
//: uses `URLSession` `dataTask(with:)` to download an image.
//: Then use this in an `OperationQueue` to download the images
//: represented by the `ids` array.
class ImageLoadOperation: AsyncOperation {
  private let url: URL
  var image: UIImage?

  init(url: URL) {
    self.url = url
    super.init()
  }
  
  // TODO: Call dataTask with url and save image
  override func main() {
    URLSession.shared.dataTask(with: self.url) { data, response, error in
      defer { self.state = .finished }
      guard error == nil else { print("Error with dataTask."); return }
      guard let httpResponse = response as? HTTPURLResponse,
            (200...299).contains(httpResponse.statusCode) else { print("Something is wrong with the HTTP response and status code. "); return }
      guard let data = data else { print("Something is wront with the Data."); return }
      guard let image = UIImage(data: data) else { print("Could not convert the data into a UIImage."); return }
      self.image = image
    }.resume()
  }
  
}
//: For each `id`, create a `url`.
//: Then, for each url, create an `ImageLoadOperation`,
//: and add it to an `OperationQueue`.
//: When each operation completes, add its output `image` to the `images` array.
let base = "https://wolverine.raywenderlich.com/books/con/image-from-rawpixel-id-"
let ids = [466881, 466910, 466925, 466931, 466978, 467028, 467032, 467042, 467052]
var images: [UIImage] = []
let queue = OperationQueue()

for id in ids {
  guard let url = URL(string: "\(base)\(id)-jpeg.jpg") else { continue }
  // TODO: Create operation with completionBlock and add to queue
  let imageLoadOperation = ImageLoadOperation(url: url)
  
  imageLoadOperation.completionBlock = {
    print(Thread.isMainThread)
    guard let image = imageLoadOperation.image else { return }
    images.append(image)
  }
  
  queue.addOperation(imageLoadOperation)
}

duration {
  queue.waitUntilAllOperationsAreFinished()
}

images[7]
images
PlaygroundPage.current.finishExecution()
