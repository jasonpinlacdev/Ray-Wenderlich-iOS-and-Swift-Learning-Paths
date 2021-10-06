//
//  ViewController.swift
//  UIKit Fundamentals StoryPrompt App
//
//  Created by Jason Pinlac on 9/2/21.
//

import UIKit
import PhotosUI

class ViewController: UIViewController {

  @IBOutlet var nounTextField: UITextField!
  @IBOutlet var adjectiveTextField: UITextField!
  @IBOutlet var verbTextField: UITextField!
  @IBOutlet var numberLabel: UILabel!
  @IBOutlet var numberSlider: UISlider!
  @IBOutlet var imageView: UIImageView!
  
  
  let storyPrompt = StoryPromptEntry()
  
  
  var isStoryPromptValid: Bool {
    return !nounTextField.text!.isEmpty && !adjectiveTextField.text!.isEmpty && !verbTextField.text!.isEmpty
  }
  
  
  override func viewDidLoad() {
    super.viewDidLoad()
    title = "New Story Prompt"
    numberSlider.value = 7.5
    numberLabel.text = "Number: \(Int(numberSlider.value))"
    storyPrompt.number = Int(numberSlider.value)
    
    nounTextField.delegate = self
    adjectiveTextField.delegate = self
    verbTextField.delegate = self
    
    nounTextField.returnKeyType = .done
    adjectiveTextField.returnKeyType = .done
    verbTextField.returnKeyType = .done
    
    let viewTapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(endEditing))
    view.addGestureRecognizer(viewTapGestureRecognizer)
    
    imageView.isUserInteractionEnabled = true
    let imageViewTapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(changeImage))
    imageView.addGestureRecognizer(imageViewTapGestureRecognizer)
  }


  @IBAction func changeNumber(_ sender: UISlider) {
    let number = Int(sender.value)
    numberLabel.text = "Number: \(number)"
    storyPrompt.number = number
    
    nounTextField.autocorrectionType = .no
    adjectiveTextField.autocorrectionType = .no
    verbTextField.autocorrectionType = .no
  }
  
  
  @IBAction func changeStoryType(_ sender: UISegmentedControl) {
    let selectedIndex = sender.selectedSegmentIndex
    if let genre = StoryPrompts.Genre(rawValue: selectedIndex) {
      storyPrompt.genre = genre
    } else {
      storyPrompt.genre = .scifi
    }
  }
  
  
  @IBAction func generateStoryPrompt(_ sender: UIButton) {
    guard isStoryPromptValid else {
      self.presentAnAlertViewController(title: "Invalid Story Prompt", message: "All text fields must be filled in.", actionTitle: "Okay", completionHandler: nil)
      return
    }
    storyPrompt.noun = nounTextField.text!
    storyPrompt.adjective = adjectiveTextField.text!
    storyPrompt.verb = verbTextField.text!
    storyPrompt.text = StoryPrompts.promptFor(genre: storyPrompt.genre)
    
    performSegue(withIdentifier: "StoryPromptViewController", sender: nil)
  }
  
  
  @objc func changeImage() {
    var configuration = PHPickerConfiguration()
    configuration.filter = .images
    configuration.selectionLimit = 1
    
    let phPickerViewController = PHPickerViewController(configuration: configuration)
    phPickerViewController.delegate = self
    present(phPickerViewController, animated: true)
  }
  
  
  @objc func endEditing() {
    self.view.endEditing(true)
  }
  
  
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    if segue.identifier == "StoryPromptViewController" {
      guard let storyPromptViewController = segue.destination as? StoryPromptViewController else { return }
      storyPromptViewController.storyPrompt = storyPrompt
    }
  }
  
}


// MARK: - extension UITextFieldDelegate -
extension ViewController: UITextFieldDelegate {
  
  func textFieldShouldReturn(_ textField: UITextField) -> Bool {
    return textField.resignFirstResponder()
  }
  
}


// MARK: - extension PHPickerViewControllerDelegate - 
extension ViewController: PHPickerViewControllerDelegate {
  
  func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
    if !results.isEmpty {
      if let result = results.first {
        let itemProvider = result.itemProvider
        if itemProvider.canLoadObject(ofClass: UIImage.self)
        {
          itemProvider.loadObject(ofClass: UIImage.self) { [weak self] image, error in
            guard let image = image as? UIImage else { return }
            DispatchQueue.main.async { self?.imageView.image = image }
          }
        }
      }
    }
  }
  
}

