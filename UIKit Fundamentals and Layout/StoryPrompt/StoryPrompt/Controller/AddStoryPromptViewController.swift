//
//  ViewController.swift
//  StoryPrompt
//
//  Created by Jason Pinlac on 1/25/21.
//

// MARK: HOW TO PERFORM A SEGUE WAY PROGRAMMATICALLY USING THE PREPARE(SEGUE:, SENDER:) METHOD AND PERFORMSEGUE(WITH IDENTIFIER:, SENDER:). The perform segue triggers the transition on the screen from the first viewcontroller to the second. If you want to prepare any data for the second view controller you use the prepare method and its segue.iditifier and segue.destination as? DestionationVC. Also, the sender param is Any? object. So it can be anything you want to send to the prepare method from the performSegue method.

import UIKit
import PhotosUI

class AddStoryPromptViewController: UIViewController {
    @IBOutlet var nounTextField: UITextField!
    @IBOutlet var adjectiveTextField: UITextField!
    @IBOutlet var verbTextField: UITextField!
    @IBOutlet var numberLabel: UILabel!
    @IBOutlet var numberSlider: UISlider! {
        didSet {
            numberLabel.text = "Number: \(Int(numberSlider.value))"
        }
    }
    @IBOutlet var pictureImageView: UIImageView!
    @IBOutlet var segmentedControl: UISegmentedControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    @IBAction func GenerateStoryPrompt(_ sender: UIButton) {
        // performSegue method is the way to programmatically and manually invoke the prepare(for segue) method.
        performSegue(withIdentifier: "GenerateStoryPrompt", sender: nil)
    }
    
    // the prepare(for segue) method is what you override when a segue way from IB is triggered. Use the segue's identifier and destination property to specify which segue and code you want to execute.
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (nounTextField.text?.isEmpty)! || (adjectiveTextField.text?.isEmpty)! || (verbTextField.text?.isEmpty)!  {
            let alertController = UIAlertController(title: "Invalid Story Prompt", message: "Fill out all textfields.", preferredStyle: .alert)
            alertController.addAction(UIAlertAction(title: "Dismiss", style: .default))
            present(alertController, animated: true)
        } else {
            if segue.identifier == "GenerateStoryPrompt" {
                guard let storyPromptViewController = segue.destination as? StoryPromptViewController else { return }
                let storyPrompt = StoryPromptEntry()
                storyPrompt.number = Int(numberSlider.value)
                storyPrompt.noun = nounTextField.text!
                storyPrompt.adjective = adjectiveTextField.text!
                storyPrompt.verb = verbTextField.text!
                storyPrompt.genre = StoryPrompts.Genre(rawValue: segmentedControl.selectedSegmentIndex)!
                storyPrompt.text = StoryPrompts.promptFor(genre: storyPrompt.genre)
                storyPrompt.image = pictureImageView.image
                storyPromptViewController.storyPrompt = storyPrompt
            }
        }
    }
}


// MARK: Private Methods
private extension AddStoryPromptViewController {
    func setup() {
        nounTextField.delegate = self
        adjectiveTextField.delegate = self
        verbTextField.delegate = self
        
        pictureImageView.isUserInteractionEnabled = true
        let pictureTapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(changePictureImage))
        pictureImageView.addGestureRecognizer(pictureTapGestureRecognizer)
    }
    
    @IBAction func sliderValueChanged(_ sender: UISlider) {
        let numberValue = Int(sender.value)
        numberLabel.text = "Number: \(numberValue)"
    }
    
    @objc func changePictureImage() {
        var configuration = PHPickerConfiguration()
        configuration.filter = .images
        configuration.selectionLimit = 1
        let controller = PHPickerViewController(configuration: configuration)
        controller.delegate = self
        present(controller, animated: true)
    }
    
}


// MARK: UITextFieldDelegate
extension AddStoryPromptViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
    }
}


// MARK: PHPickerViewControllerDelegate
extension AddStoryPromptViewController: PHPickerViewControllerDelegate {
    func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
        if !results.isEmpty {
            let result = results.first!
            let itemProvider = result.itemProvider
            if itemProvider.canLoadObject(ofClass: UIImage.self) {
                itemProvider.loadObject(ofClass: UIImage.self) { [weak self] image, error in
                    guard let image = image as? UIImage else { return }
                    DispatchQueue.main.async {
                        self?.pictureImageView.image = image
                        picker.dismiss(animated: true, completion: nil)
                    }
                    
                }
            }
        }
    }
}
