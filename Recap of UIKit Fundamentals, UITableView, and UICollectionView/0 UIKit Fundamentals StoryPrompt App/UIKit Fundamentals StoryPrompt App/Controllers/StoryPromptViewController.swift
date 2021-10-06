//
//  StoryPromptViewController.swift
//  UIKit Fundamentals StoryPrompt App
//
//  Created by Jason Pinlac on 9/3/21.
//

import UIKit

class StoryPromptViewController: UIViewController {
  
  @IBOutlet var textView: UITextView!
  
  var storyPrompt: StoryPromptEntry?
  
  override func viewDidLoad() {
    super.viewDidLoad()
    textView.isUserInteractionEnabled = false
    if let storyPrompt = storyPrompt {
      textView.text = storyPrompt.description
    }
  }
  
  
//  override func viewWillAppear(_ animated: Bool) {
//    super.viewWillAppear(animated)
//    self.navigationController?.setNavigationBarHidden(true, animated: true)
//  }
  
  
//  override func viewWillDisappear(_ animated: Bool) {
//    super.viewWillDisappear(animated)
//    self.navigationController?.setNavigationBarHidden(false, animated: true)
//  }
  
}
