//
//  ViewController.swift
//  4 Making a HTTP POST Request
//
//  Created by Jason Pinlac on 5/18/21.
//

import UIKit

class ViewController: UIViewController {

  @IBOutlet var textView: UITextView!
  @IBOutlet var postRequestButton: UIButton!
  
  override func viewDidLoad() {
    super.viewDidLoad()
  }
  
  @IBAction func performPostRequest(_ sender: Any) {
    let jsonString = "{'Hello': 'World'}"
    let jsonData = jsonString.data(using: .utf8)
    
    let configuration = URLSessionConfiguration.default
    configuration.waitsForConnectivity = true
    
    let url = URL(string: "https://httpbin.org/post")!
    
    var request = URLRequest(url: url)
    request.httpMethod = "POST"
    request.httpBody = jsonData
    
    let session = URLSession(configuration: configuration)
    let task = session.dataTask(with: request) { data, urlResponse, error in
      if let data = data {
        if let postResponse = String(data: data, encoding: .utf8) {
          print(postResponse)
          
          OperationQueue.main.addOperation { [weak self] in
            self?.textView.text = postResponse
          }
         
        }
      }
    }
    task.resume()
  }


}

