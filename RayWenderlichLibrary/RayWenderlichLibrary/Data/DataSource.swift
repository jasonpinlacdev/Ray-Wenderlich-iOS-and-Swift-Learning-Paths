//
//  DataSource.swift
//  RayWenderlichLibrary
//
//  Created by Jason Pinlac on 10/7/20.
//  Copyright © 2020 Ray Wenderlich. All rights reserved.
//

import UIKit

class DataSource {
    
    static let shared = DataSource()
    
    private let decoder = PropertyListDecoder()
    
    var tutorials: [TutorialCollection]

    private init() {
        guard let tutorialsURL = Bundle.main.url(forResource: "Tutorials", withExtension: "plist"),
              let tutorialsData = try? Data(contentsOf: tutorialsURL),
              let tutorials = try? decoder.decode([TutorialCollection].self, from: tutorialsData) else { self.tutorials = []; print("Failed"); return }
        self.tutorials = tutorials
    }
}
