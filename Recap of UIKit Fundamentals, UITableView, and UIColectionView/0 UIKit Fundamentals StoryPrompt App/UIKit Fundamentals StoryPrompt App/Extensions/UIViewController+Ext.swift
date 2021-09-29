//
//  UIViewController+Ext.swift
//  UIKit Fundamentals StoryPrompt App
//
//  Created by Jason Pinlac on 9/3/21.
//

import UIKit


extension UIViewController {
  
  func presentAnAlertViewController(title: String, message: String, actionTitle: String, completionHandler: (() -> Void)? = nil) {
    let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
    alertController.addAction(UIAlertAction(title: actionTitle, style: .default, handler: nil))
    present(alertController, animated: true, completion: completionHandler)
  }
}
