//
//  File.swift
//  UICollectionView using Compositional Layout and Diffable DataSource
//
//  Created by Jason Pinlac on 3/28/21.
//

import UIKit

class Data {
    
    enum Section: String, CaseIterable {
        case ones = "ONES"
        case tens  = "TENS"
        case twenties = "TWENTIES"
        case thirties = "THIRTIES"
        case forties = "FOURTIES"
        case fifties = "FIFTIES"
        case sixties = "SIXTIES"
        case seventies = "SEVENTIES"
        case eighties = "EIGHTIES"
        case nineties = "NINETIES"
    }
    
    static let shared = Data()
    
    private init() { }
    
    let numbers: [Section: [Int]] = [
        .ones: Array(0...9),
        .tens: Array(10...19),
        .twenties: Array(20...29),
        .thirties: Array(30...39),
        .forties: Array(40...49),
        .fifties: Array(50...59),
        .sixties: Array(60...69),
        .seventies: Array(70...79),
        .eighties: Array(80...89),
        .nineties: Array(90...99),
    ]

}
