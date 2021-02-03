//
//  StoryPromptViewController.swift
//  StoryPrompt
//
//  Created by Jason Pinlac on 1/26/21.
//

import UIKit

class StoryPromptViewController: UIViewController {
    
    @IBOutlet var storyPromptTextView: UITextView!
    
    var storyPrompt: StoryPromptEntry?
    
    var isNewStoryPrompt = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if isNewStoryPrompt {
            navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(cancelStoryPrompt))
            navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(saveStoryPrompt))
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        storyPromptTextView.text = storyPrompt?.description
        storyPromptTextView.flashScrollIndicators()
    }
    
    @objc func cancelStoryPrompt() {
        performSegue(withIdentifier: "CancelStoryPrompt", sender: nil)
    }
    
    @objc func saveStoryPrompt() {
        performSegue(withIdentifier: "SaveStoryPrompt", sender: nil)
    }
    
}
