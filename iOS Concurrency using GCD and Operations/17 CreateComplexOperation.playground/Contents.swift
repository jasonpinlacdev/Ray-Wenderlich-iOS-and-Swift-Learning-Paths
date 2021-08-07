// Copyright (c) 2020 Razeware LLC
// For full license & permission details, see LICENSE.markdown.

import UIKit
import PlaygroundSupport
PlaygroundPage.current.needsIndefiniteExecution = true
//: # Creating a Complex Operation
//: ## Subclassing `Operation`
//: Allows you more control over precisely what the `Operation` is doing
let inputImage = UIImage(named: "dark_road_small.jpg")

// TODO: Create and run TiltShiftOperation
class TiltShiftOperation: Operation {
  
  private let context = CIContext()
  private let inputImage: UIImage?
  var outputImage: UIImage?

  
  init(inputImage: UIImage?) {
    self.inputImage = inputImage
    super.init()
  }
  
  override func main() {
    guard let input = self.inputImage,
          let filter = TiltShiftFilter(image: input),
          let output = filter.outputImage
    else {
      print("Failed to generate a tilt shift image.")
      return
    }
  
    let fromRect = CGRect(origin: .zero, size: input.size)
    guard let cgImage = context.createCGImage(output, from: fromRect) else {
      print("Failed to generate a titlt shift operation.")
      return
    }
    
    self.outputImage = UIImage(cgImage: cgImage)
  }
  
}

let tiltShiftOperation = TiltShiftOperation(inputImage: inputImage)

tiltShiftOperation.completionBlock = {
  tiltShiftOperation.outputImage
}

duration {
tiltShiftOperation.start() // this is a sync call
}
