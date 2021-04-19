//
//  FlickerTableViewController.swift
//  FlickrImages URLSession App
//
//  Created by Jason Pinlac on 4/18/21.
//

import UIKit

class FlickrTableViewController: UIViewController {
  
  var photos: [FlickrPhoto] = []
  
  var diffDataSource: FlickrDiffableDataSource!
  
  @IBOutlet var tableView: UITableView!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    title = "Flickr Photos URLSession"
    configureDiffDataSource()
    loadFlickrImage()
  }
  
  func loadFlickrImage() {

    let urlSessionConfiguration = URLSessionConfiguration.ephemeral
    let urlSession = URLSession(configuration: urlSessionConfiguration)
    let url = URL(string: "https://api.flickr.com/services/feeds/photos_public.gne?format=json&nojsoncallback=1")!

    let task = urlSession.dataTask(with: url)  {  (data, response, error) in
      guard let response = response as? HTTPURLResponse,
            response.statusCode == 200 else { return }
      guard let data = data else { print(error.debugDescription); return }
      do {
        let media = try JSONDecoder().decode(FlickrJSON.self, from: data)
        for item in media.items {
          if let imageURL = item.media["m"] {
            let url = URL(string: imageURL)!
            let imageData = try Data(contentsOf: url)
            if let image = UIImage(data: imageData) {
              let flickrImage = FlickrPhoto(title: item.title, image: image)
              self.photos.append(flickrImage)
            }
          }
        }
        
        let queue = OperationQueue.main
        queue.addOperation {
          self.diffDataSource.update(with: self.photos)
        }
        
        
      } catch {
        print("Error info: \(error)")
      }
    }
    
    task.resume()
  }
  
  func configureDiffDataSource() {
    diffDataSource = FlickrDiffableDataSource(tableView: self.tableView, cellProvider: { (tableView, indexPath, flickrPhoto) -> UITableViewCell? in
      guard let flickrCell = tableView.dequeueReusableCell(withIdentifier: FlickrCell.reuseId) as? FlickrCell else { fatalError() }
      flickrCell.textLabel?.text = flickrPhoto.title
      flickrCell.imageView?.image = flickrPhoto.image
      return flickrCell
    })
  }
  
  
  
}
