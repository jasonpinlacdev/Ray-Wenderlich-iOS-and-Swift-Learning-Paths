//
//  ViewController.swift
//  ImageViewer
//
//  Created by Brian on 8/23/18.
//  Copyright © 2018 Razeware. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
  
  @IBOutlet weak var imageView: UIImageView!
  @IBOutlet weak var segmentedControl: UISegmentedControl!
  
  let imageUrls = [
    URL(string: "https://koenig-media.raywenderlich.com/uploads/2018/05/OperationQueue-feature.png")!,
    URL(string: "https://koenig-media.raywenderlich.com/uploads/2018/08/Sceneform-feature.png")!,
    URL(string: "https://koenig-media.raywenderlich.com/uploads/2018/07/Timeline-feature.png")!
  ]
  
  override func viewDidLoad() {
    super.viewDidLoad()
    displayImage(index: 0)
  }
  
  @IBAction func tappedSegment(_ sender: Any) {
    displayImage(index: segmentedControl.selectedSegmentIndex)
  }
  
  func displayImage(index: Int) {
    
    let downloadURL = imageUrls[index]
    let configuration = URLSessionConfiguration.default
    configuration.waitsForConnectivity = true
    let session = URLSession(configuration: configuration)
    let downloadTask = session.downloadTask(with: downloadURL) { [weak self] location, urlResponse, error in
      guard let location = location else { return }
      guard let imageData = self?.getImageData(location: location) else { return }
      guard let image = UIImage(data: imageData) else { return }
      
      OperationQueue.main.addOperation {
        self?.imageView.image = image
      }
   
    }
    downloadTask.resume()
    
  }
  
  func getImageData(location: URL) -> Data? {
    var imageData: Data? = nil
    do {
      try imageData = Data(contentsOf: location)
    } catch {
      
    }
    return imageData
    
  }
  
  
}

