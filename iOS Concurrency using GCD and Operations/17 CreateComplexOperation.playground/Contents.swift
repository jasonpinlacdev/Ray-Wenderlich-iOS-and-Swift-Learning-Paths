// Copyright (c) 2020 Razeware LLC
// For full license & permission details, see LICENSE.markdown.

import UIKit
import PlaygroundSupport
PlaygroundPage.current.needsIndefiniteExecution = true
//: # Creating a Complex Operation
//: ## Subclassing `Operation`
//: Allows you more control over precisely what the `Operation` is doing
class TiltShiftOperation: Operation {
  private let inputImage: UIImage?
  var outputImage: UIImage?
  private static let context = CIContext()
  
  init(image: UIImage?) {
    self.inputImage = image
    super.init()
  }
  
  override func main() {
    guard let inputImage = self.inputImage,
          let filter = TiltShiftFilter(image: inputImage),
          let output = filter.outputImage
    else { print("Image filter failed."); return }
    
    let fromRect = CGRect(origin: .zero, size: inputImage.size)
    guard let cgImage = TiltShiftOperation.context.createCGImage(output, from: fromRect) else { print("No output image generated."); return }
    self.outputImage = UIImage(cgImage: cgImage)
  }
}

let inputImage = UIImage(named: "dark_road_small.jpg")
// TODO: Create and run TiltShiftOperation
let tiltShiftOperation = TiltShiftOperation(image: inputImage)
tiltShiftOperation.start()
tiltShiftOperation.outputImage
PlaygroundPage.current.finishExecution()
