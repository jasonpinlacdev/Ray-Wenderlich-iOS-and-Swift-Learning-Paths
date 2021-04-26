//
//  ViewController.swift
//  Making a POST request
//
//  Created by Jason Pinlac on 4/19/21.
//

import UIKit

class ViewController: UIViewController {
  
  @IBOutlet var textView: UITextView!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    title = "Post Request Demo"
  }
  
  @IBAction func createPostRequest(_ sender: Any) {
    let json = "{'Hello': 'World'}"
    
    let url = URL(string: "https://httpbin.org/post")!
    var urlRequest = URLRequest(url: url)
    urlRequest.httpBody = json.data(using: .utf8)
    urlRequest.httpMethod = "POST"

    let urlSessionConfiguration = URLSessionConfiguration.default
    urlSessionConfiguration.waitsForConnectivity = true

    let urlSession = URLSession(configuration: urlSessionConfiguration)

    let task = urlSession.dataTask(with: urlRequest) { [weak self] (data, response, error) in
      if let data = data {
        let postResponse = String(data: data, encoding: .utf8)
        OperationQueue.main.addOperation { self?.textView.text = postResponse }
      }
    }
    task.resume()
    
  }
  
  
}


