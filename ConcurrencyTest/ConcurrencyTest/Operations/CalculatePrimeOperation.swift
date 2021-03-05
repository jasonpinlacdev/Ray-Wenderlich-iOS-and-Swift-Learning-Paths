//
//  CalculatePrimeOperation.swift
//  ConcurrencyTest
//
//  Created by Jason Pinlac on 3/4/21.
//

import Foundation

class CalculatePrimeOperation: Operation {
   
    override func main() {
        (1...1_000_000).forEach { print("\($0): \(self.isPrime(number: $0))") }
    }
    
    func isPrime(number: Int) -> Bool {
        if number <= 1 { return false }
        if number <= 3 { return true }
        var i = 2
        while i < number {
            if number % i == 0 { return false }
            i += 1
        }
        return true
    }
    
}
