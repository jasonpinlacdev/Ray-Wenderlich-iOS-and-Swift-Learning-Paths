//
//  DataRepository.swift
//  CollectionView
//
//  Created by Jason Pinlac on 9/15/21.
//

import Foundation

class DataRepository {
  
  static let shared = DataRepository()
  
  private init() {}
  
  let numbersData: [NumbersSection: [Int]] = [
    .ones : [0,1,2,3,4,5,6,7,8,9],
    .tens : [10,11,12,13,14,15,16,17,18,19],
    .twenties : [20,21,22,23,24,25,26,27,28,29],
    .thirties : [30,31,32,33,34,35,36,37,38,39],
    .forties : [40,41,42,43,44,45,46,47,48,49],
    .fifties : [50,51,52,53,54,55,56,57,58,59],
    .sixties : [60,61,62,63,64,65,66,67,68,69],
    .seventies : [70,71,72,73,74,75,76,77,78,79],
    .eighties : [80,81,82,83,84,85,86,87,88,89],
    .nineties : [90,91,92,93,94,95,96,97,98,99]
  ]
  
}
