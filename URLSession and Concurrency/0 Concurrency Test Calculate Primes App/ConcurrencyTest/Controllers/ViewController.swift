//
//  ViewController.swift
//  ConcurrencyTest
//
//  Created by Jason Pinlac on 4/15/21.
//

import UIKit

class ViewController: UIViewController {
  
  @IBOutlet var primeNumberButton: UIButton!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view.
  }
  
  
  // MARK: - 1st way to execute an operation on the operation queue; using a subclass of Operation. Adding the operation will execute that code in the overriden main method of the subclassed Operation. -
//  @IBAction func calculatePrimeNumbers(_ sender: Any) {
//    let operationQueue = OperationQueue()
//    let calculatePrimeOperation = CalculatePrimeOperation()
//    operationQueue.addOperation(calculatePrimeOperation)
//    }
//  }
  
  
  // MARK: - 2nd way to execute an operation on the operation queue; adding an inline closure that contains the task we want to execute concurrently. -
  @IBAction func calculatePrimeNumbers(_ sender: Any) {
    disablePrimeButton()
    let operationQueue = OperationQueue()
    operationQueue.addOperation {
      (0...100_000).forEach {
        if self.isPrime(number: $0) { print("\($0) is prime")}
      }
      OperationQueue.main.addOperation { self.enablePrimeButton() }
    }
  }

  func enablePrimeButton() {
    primeNumberButton.setTitle("Calculate Prime Numbers", for: .normal)
    primeNumberButton.isEnabled = true
  }
  
  func disablePrimeButton() {
    primeNumberButton.setTitle("Calculating...", for: .normal)
    primeNumberButton.isEnabled = false
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
