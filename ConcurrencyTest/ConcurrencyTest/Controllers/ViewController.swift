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
        let queue = OperationQueue()
        let operation = CalculatePrimeOperation()
        queue.addOperation(operation)
       
    }
    
   
    
}

