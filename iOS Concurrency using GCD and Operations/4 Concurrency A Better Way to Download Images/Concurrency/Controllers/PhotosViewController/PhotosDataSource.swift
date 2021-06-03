import UIKit

class PhotosDataSource: NSObject {
  let urls = DataRepository.shared.urls
  
  // MARK: - Download and update the PhotoCell's imageView property using the .utility Global DispatchQueue (GCD). -
  private func downloadWithGlobalQueue(at indexPath: IndexPath, for collectionView: UICollectionView) {
    DispatchQueue.global(qos: .utility).async { [weak self] in
      guard let self = self else { return }
      if let imageData = try? Data(contentsOf: self.urls[indexPath.item]),
         let image = UIImage(data: imageData) {
        DispatchQueue.main.async {
          if let photoCell = collectionView.cellForItem(at: indexPath) as? PhotoCell {
            photoCell.imageView.image = image
          }
        }
      }
    }
  }
  
  // MARK: - Download and update the PhotoCell's imageView property using a URLSession and URLSession DataTask instance. -
  private func downloadWithURLSession(at indexPath: IndexPath, for collectionView: UICollectionView) {
    URLSession.shared.dataTask(with: urls[indexPath.item]) { data, urlResponse, error in
      if let urlResponse = urlResponse as? HTTPURLResponse, (0...200).contains(urlResponse.statusCode),
         let data = data,
         let image = UIImage(data: data) {
        DispatchQueue.main.async {
          if let photoCell = collectionView.cellForItem(at: indexPath) as? PhotoCell {
            photoCell.imageView.image = image
          }
        }
      }
      
    }.resume()
  }
  
}

extension PhotosDataSource: UICollectionViewDataSource {
  
  func numberOfSections(in collectionView: UICollectionView) -> Int {
    return 1
  }
  
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return urls.count
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    guard let photoCell = collectionView.dequeueReusableCell(withReuseIdentifier: "PhotoCell", for: indexPath) as? PhotoCell else { fatalError("Failed to dequeue a PhotoCell.")}
    photoCell.imageView.image = nil
    //      downloadWithGlobalQueue(at: indexPath, for: collectionView)
    downloadWithURLSession(at: indexPath, for: collectionView)
    return photoCell
  }
  
  
  
}
