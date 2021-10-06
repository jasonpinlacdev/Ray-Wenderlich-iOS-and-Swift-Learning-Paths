import Foundation

struct Section: Codable {
  let title: String
  let videos: [Video]
  let uniqueIdentifier = UUID().uuidString
  
  enum CodingKeys: String, CodingKey {
    case title = "title"
    case videos = "videos"
  }
}

extension Section: Hashable {
  func hash(into hasher: inout Hasher) {
    hasher.combine(uniqueIdentifier)
  }
  
  static func ==(lhs: Section, rhs: Section) -> Bool {
    return lhs.uniqueIdentifier == rhs.uniqueIdentifier
  }
}
