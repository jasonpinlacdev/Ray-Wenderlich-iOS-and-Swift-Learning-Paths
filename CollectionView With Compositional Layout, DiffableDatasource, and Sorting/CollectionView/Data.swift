//
//  Collection.swift
//  CollectionView
//
//  Created by Jason Pinlac on 3/2/21.
//

import UIKit

class Data {
    
    // singleton
    static let shared = Data()
    
    let numbers: [Int]
    
    private init() {
        numbers = Array(Set(1...300))
    }
    
    
    
}
