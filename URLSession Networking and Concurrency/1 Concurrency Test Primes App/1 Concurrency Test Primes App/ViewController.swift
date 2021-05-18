//
//  ViewController.swift
//  1 Concurrency Test Primes App
//
//  Created by Jason Pinlac on 5/17/21.
//

import UIKit

class ViewController: UIViewController {
  
  @IBOutlet var datePicker: UIDatePicker!
  @IBOutlet var calculatePrimesButton: UIButton!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view.
  }
  
  @IBAction func calculatePrimes(_ sender: UIButton) {
    let operationQueue = OperationQueue()
    operationQueue.addOperation { [weak self] in
      guard let self = self else { fatalError() }
      self.enableCalculatePrimesButton(false)
      self.calculatePrimeNumbers(upTo: 10_000)
      self.enableCalculatePrimesButton(true)
    }
  }
  
  func calculatePrimeNumbers(upTo limit: Int) {
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
  
  func enableCalculatePrimesButton(_ isEnabled: Bool) {
    let mainOperationQueue = OperationQueue.main
    mainOperationQueue.addOperation { [weak self] in
      guard let self = self else { fatalError() }
      if isEnabled {
        self.calculatePrimesButton.setTitle("Calculate Prime Numbers", for: .normal)
      } else {
        self.calculatePrimesButton.setTitle("Calculating...", for: .normal)
      }
      self.calculatePrimesButton.isEnabled = isEnabled
    }
  }
  
}



