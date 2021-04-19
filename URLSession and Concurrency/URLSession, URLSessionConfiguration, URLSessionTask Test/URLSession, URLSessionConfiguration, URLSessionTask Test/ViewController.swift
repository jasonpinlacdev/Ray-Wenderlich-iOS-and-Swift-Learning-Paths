//
//  ViewController.swift
//  URLSession, URLSessionConfiguration, URLSessionTask Test
//
//  Created by Jason Pinlac on 4/16/21.
//

import UIKit

class ViewController: UIViewController {

  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view.
    
    print("viewDidLoad")
    

    // setup the session configuration
    let configuration = URLSessionConfiguration.default
    configuration.waitsForConnectivity = true

    // setup the URLSession object
    let urlSession = URLSession(configuration: configuration)

    guard let url = URL(string: "http://jsonplaceholder.typicode.com/users") else { fatalError() }

    let task = urlSession.dataTask(with: url) { (data: Data?, response: URLResponse?, error: Error?) in
    
      // check response
      guard let response = response as? HTTPURLResponse,
            response.statusCode == 200 else { return }
      
      // check data
      guard let data = data else { print(error.debugDescription); return }
      
      if let result = NSString(data: data, encoding: String.Encoding.utf8.rawValue) as String? {
        print(result)
      }
    }
    task.resume()
  }


}

