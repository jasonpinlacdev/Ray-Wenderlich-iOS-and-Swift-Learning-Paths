//
//  Collection.swift
//  CollectionView
//
//  Created by Jason Pinlac on 3/2/21.
//

import UIKit

class Data {
    
    // singleton - Only a class can truly be a singleton because they are references to a single instance in memory. Structs are not true singletons because if you make an assignment, its a copy of the instance therefore existing more than 1 single instance.
    
    static let shared = Data()
    
    let numbers: [Int]
    
    private init() {
        numbers = Array(Set(1...300))
    }
    
    
    
}


//struct DataB {
//
//    static let shared = DataB()
//
//    static let numbers = Array(Set(1...300))
//
//    private init() {}
//}
