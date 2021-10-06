import Foundation

struct Genre: Codable {
  let title: String
  let tutorials: [Tutorial]
  let uniqueIdentifier = UUID().uuidString
  
  enum CodingKeys: String, CodingKey {
    case title = "title"
    case tutorials = "tutorials"
  }
}

extension Genre: Hashable {
  func hash(into hasher: inout Hasher) {
    hasher.combine(self.uniqueIdentifier)
  }
  
  static func ==(lhs: Genre, rhs: Genre) -> Bool {
    return lhs.uniqueIdentifier == rhs.uniqueIdentifier
  }
}


