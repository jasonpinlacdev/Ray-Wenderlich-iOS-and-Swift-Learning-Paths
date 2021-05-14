//
//  DataRepository.swift
//  RayWenderlichLibrary
//
//  Created by Jason Pinlac on 5/12/21.
//  Copyright © 2021 Ray Wenderlich. All rights reserved.
//

import UIKit


class DataRepository {
  static let shared = DataRepository()
  let tutorialCollections: [TutorialCollection]
  
  var queuedTutorials: [Tutorial] {
    get {
      var queuedTutorials = [Tutorial]()
      tutorialCollections.forEach { tutorialCollection in
        tutorialCollection.tutorials.forEach { tutorial in
          if tutorial.isQueued { queuedTutorials.append(tutorial) }
        }
      }
      return queuedTutorials
    }
  }
  
  private init() {
    guard let url = Bundle.main.url(forResource: "Tutorials", withExtension: "plist") else { fatalError() }
    guard let data = try? Data(contentsOf: url) else { fatalError() }
    guard let tutorialCollections = try? PropertyListDecoder().decode([TutorialCollection].self, from: data) else { fatalError() }
    self.tutorialCollections = tutorialCollections
  }
  
  
}
