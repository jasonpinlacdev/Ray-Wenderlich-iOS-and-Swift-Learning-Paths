//
//  CalculatePrimesOperation.swift
//  1 Concurrency Test Primes App
//
//  Created by Jason Pinlac on 5/17/21.
//

import Foundation


class CalculatePrimesOperation: Operation {
  override func main() {
    calculatePrimeNumbers(upTo: 1_000_000)
  }
  
  private func calculatePrimeNumbers(upTo limit: Int) {
    let range = 1 ... limit
    for number in range {
      if number == 1 { print("\(number) is prime"); continue }
      
      var primeFlag = true
      
      let multiplerRange = 2 ..< number
      for multipler in multiplerRange {
        if number % multipler == 0 {
          print("\(number) is not prime")
          primeFlag = false
          break
        }
      }
      
      if primeFlag == true {
        print("\(number) is prime")
      }
      
    }
  }
}
