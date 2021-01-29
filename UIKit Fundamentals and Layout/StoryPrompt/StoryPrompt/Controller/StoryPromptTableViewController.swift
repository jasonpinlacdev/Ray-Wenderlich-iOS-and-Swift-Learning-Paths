//
//  StoryPromptTableViewController.swift
//  StoryPrompt
//
//  Created by Jason Pinlac on 1/28/21.
//

import UIKit

class StoryPromptTableViewController: UITableViewController {

    var storyPrompts: [StoryPromptEntry] = {
        let storyPrompt1 = StoryPromptEntry()
        let storyPrompt2 = StoryPromptEntry()
        let storyPrompt3 = StoryPromptEntry()
        
        storyPrompt1.number = Int.random(in: 5...10)
        storyPrompt1.noun = "toaster"
        storyPrompt1.verb = "crushed"
        storyPrompt1.adjective = "smelly"
        
        storyPrompt2.number = Int.random(in: 5...10)
        storyPrompt2.noun = "can"
        storyPrompt2.verb = "jammed"
        storyPrompt2.adjective = "hard"

        storyPrompt3.number = Int.random(in: 5...10)
        storyPrompt3.noun = "finger"
        storyPrompt3.verb = "flicked"
        storyPrompt3.adjective = "gangily"

        return [storyPrompt1, storyPrompt2, storyPrompt3]
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Prompt Selection"
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowStoryPrompt" {
            guard let storyPromptViewController = segue.destination as? StoryPromptViewController else { return }
            storyPromptViewController.storyPrompt = sender as? StoryPromptEntry
            storyPromptViewController.isNewStoryPrompt = false
        }
    }

    @IBAction func addStoryPrompt(_ sender: Any) {
        performSegue(withIdentifier: "AddStoryPrompt", sender: nil)
    }

    @IBAction func saveStoryPrompt(unwindSegue: UIStoryboardSegue) {
        // with a typical segue, we get the destination VC using segue.destination. In this case with an unwind segue we go backwards so we start at the source. Think of this method as the prepare(for segue .. ) method except that it is for the unwind segue. It is triggered when the unwind happens from the segue created from the save button in IB to the exit icon on the document outline for the StoryPromptController.
        guard let sourceViewController = unwindSegue.source as? StoryPromptViewController, let storyPrompt = sourceViewController.storyPrompt else { return }
        storyPrompts.append(storyPrompt)
        tableView.reloadData()
    }

    @IBAction func cancelStoryPrompt(unwindSegue: UIStoryboardSegue) {

    }

    
}


// MARK: UITableViewDatasource Methods
extension StoryPromptTableViewController {
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {        return storyPrompts.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "StoryPromptCell", for: indexPath)
        cell.imageView?.image = storyPrompts[indexPath.row].image
        cell.textLabel?.text = "Prompt \(indexPath.row + 1)"
        return cell
    }
}


// MARK: UITableViewDelegate Methods
extension StoryPromptTableViewController {
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "ShowStoryPrompt", sender: storyPrompts[indexPath.row])
    }
}
