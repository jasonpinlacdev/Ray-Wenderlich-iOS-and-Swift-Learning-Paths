import Foundation

class DataRepository {
  
  static let shared = DataRepository()
  
  var urls: [URL] = []
  
  private init() {
    getPListURLS()
  }
  
  private func getPListURLS() {
    guard let plistURL = Bundle.main.url(forResource: "Photos", withExtension: "plist"),
          let contentData = try? Data(contentsOf: plistURL),
          let urlsAsStrings = try? PropertyListDecoder().decode([String].self, from: contentData)
    else { print("Something went horribly wrong trying to get the URLs from the photos.plist")
      return }
    
    self.urls = urlsAsStrings.compactMap { urlString in
      return URL(string: urlString)
    }
  }

}
