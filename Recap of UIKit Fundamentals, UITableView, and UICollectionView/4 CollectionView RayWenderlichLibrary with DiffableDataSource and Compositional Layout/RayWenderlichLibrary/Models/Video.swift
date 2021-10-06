import Foundation

struct Video: Codable {
  let url: String
  let title: String
  let uniqueIdentifier = UUID().uuidString
  
  enum CodingKeys: String, CodingKey {
    case url = "url"
    case title = "title"
  }
}

extension Video: Hashable {
  func hash(into hasher: inout Hasher) {
    hasher.combine(uniqueIdentifier)
  }
  
  static func ==(lhs: Video, rhs: Video) -> Bool {
    return lhs.uniqueIdentifier == rhs.uniqueIdentifier
  }
}
