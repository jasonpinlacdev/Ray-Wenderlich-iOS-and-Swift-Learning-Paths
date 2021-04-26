//
//  CalculatePrimeOperation.swift
//  ConcurrencyTest
//
//  Created by Jason Pinlac on 4/16/21.
//

import Foundation


class CalculatePrimeOperation: Operation {
  override func main() {
    for number in 1...100_000_000 {
      if isPrime(number: number) { print("\(number) is prime") }
    }
  }
  
  func isPrime(number: Int) -> Bool {
    if number <= 1 { return false }
    
    var multiplier = 2
    while multiplier < number {
      if number % multiplier == 0 { return false }
      multiplier += 1
    }
    return true
  }
}
