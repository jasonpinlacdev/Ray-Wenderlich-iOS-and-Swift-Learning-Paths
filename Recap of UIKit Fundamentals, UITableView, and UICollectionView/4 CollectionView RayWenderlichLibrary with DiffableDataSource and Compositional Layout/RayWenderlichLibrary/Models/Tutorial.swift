import UIKit

class Tutorial: Codable {
  let title: String
  let thumbnail: String
  let artworkColor: String
  var isQueued: Bool
  let publishDate: Date
  let content: [Section]
  var updateCount: Int
  let uniqueIdentifier = UUID().uuidString
  
  enum CodingKeys: String, CodingKey {
    case title = "title"
    case thumbnail = "thumbnail"
    case artworkColor = "artworkColor"
    case isQueued = "isQueued"
    case publishDate = "publishDate"
    case content = "content"
    case updateCount = "updateCount"
  }
}


extension Tutorial {
  var image: UIImage? {
    return UIImage(named: thumbnail)
  }
  
  var imageBackgroundColor: UIColor? {
    return UIColor(hexString: artworkColor)
  }
  
  func formattedDate(using formatter: DateFormatter) -> String? {
    return formatter.string(from: publishDate)
  }
}


extension Tutorial: Hashable {
  func hash(into hasher: inout Hasher) {
    hasher.combine(uniqueIdentifier)
  }
  
  static func ==(lhs: Tutorial, rhs: Tutorial) -> Bool {
    return lhs.uniqueIdentifier == rhs.uniqueIdentifier
  }
}

