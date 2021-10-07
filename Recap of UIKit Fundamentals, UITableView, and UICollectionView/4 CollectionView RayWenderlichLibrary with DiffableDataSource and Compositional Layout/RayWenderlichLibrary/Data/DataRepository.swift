import Foundation


class DataRepository {
  
  static let shared = DataRepository()
  
  var genreCollection: [Genre] = []
    
  private init() {
    guard let genreCollectionPListURL = Bundle.main.url(forResource: "Tutorials", withExtension: "plist") else { return }
    guard let genreCollectionPListData = try? Data(contentsOf: genreCollectionPListURL) else { return }
    guard let genreCollection  = try? PropertyListDecoder().decode([Genre].self, from: genreCollectionPListData) else { return }
    self.genreCollection = genreCollection
  }
  
  func getQueuedTutorials() -> [Tutorial] {
    var queuedTutorials: [Tutorial] = []
    
    
    DataRepository.shared.genreCollection.forEach { genre in
      genre.tutorials.forEach { tutorial in
        if tutorial.isQueued {
          queuedTutorials.append(tutorial) }
      }
    }
    return queuedTutorials
  }
  
  

}
