//
//  ViewController.swift
//  ConcurrencyTest
//
//  Created by Jason Pinlac on 3/3/21.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var datePicker: UIDatePicker!
    @IBOutlet var primeNumberButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func calculatePrimeNumbers(_ sender: UIButton) {
        
        DispatchQueue.global(qos: .userInitiated).async {
            (1...1_000_000).forEach { print("\($0): \(self.isPrime(number: $0))") }
        }
      
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

