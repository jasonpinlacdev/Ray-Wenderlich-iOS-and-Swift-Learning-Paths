//
//  ViewController.swift
//  2 URLSession, URLSessionConfiguration, URLSessionTask Test
//
//  Created by Jason Pinlac on 5/18/21.
//

import UIKit

class ViewController: UIViewController {

  @IBOutlet var textView: UITextView!
  
  @IBOutlet var button: UIButton!
  
  override func viewDidLoad() {
    super.viewDidLoad()
  
  }

  @IBAction func buttonTapped(_ sender: UIButton) {
    let configuration = URLSessionConfiguration.default
    configuration.waitsForConnectivity = true
    let session = URLSession(configuration: configuration)
    
    let url = URL(string: "https://jsonplaceholder.typicode.com/users")!
    let task = session.dataTask(with: url) { [weak self] data, response, error in
      guard let self = self else { return }
      if let error = error {
        print(error)
        return
      }
      guard let response = response as? HTTPURLResponse, response.statusCode == 200 else { return }
      if let data = data {
        if let result = String(data: data, encoding: .utf8) {
          print(result)
          
          let mainOperationQueue = OperationQueue.main
          mainOperationQueue.addOperation {
            self.textView.text = result
          }
        }
      }
    }
    task.resume()
  }
  
}

