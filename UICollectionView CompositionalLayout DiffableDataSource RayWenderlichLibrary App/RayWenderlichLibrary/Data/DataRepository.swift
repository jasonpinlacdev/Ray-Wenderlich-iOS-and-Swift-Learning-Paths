//
//  DataRepository.swift
//  RayWenderlichLibrary
//
//  Created by Jason Pinlac on 4/2/21.
//  Copyright © 2021 Ray Wenderlich. All rights reserved.
//

import UIKit

class DataRepository {
  static let shared = DataRepository()
  var topics: [TutorialsCollection] = []
  
  private init() {
    guard let topicsURL = Bundle.main.url(forResource: "Tutorials", withExtension: "plist") else { fatalError() }
    guard let topicsData = try? Data(contentsOf: topicsURL) else { fatalError() }
    guard let topics = try? PropertyListDecoder().decode([TutorialsCollection].self, from: topicsData) else { fatalError() }
    self.topics = topics
  }
}
