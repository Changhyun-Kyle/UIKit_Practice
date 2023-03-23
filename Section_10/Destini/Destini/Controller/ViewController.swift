//
//  ViewController.swift
//  Destini
//
//  Created by 강창현 on 2023/03/23.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var storyTextLabel: UILabel!
    @IBOutlet weak var choice1: UIButton!
    @IBOutlet weak var choice2: UIButton!
    
    var storyBrain = StoryBrain()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        updateUI()
    }

    @IBAction func choiceButtonPressed(_ sender: UIButton) {
        storyBrain.nextStory(sender.currentTitle!)
        updateUI()
    }
    
    func updateUI() {
        storyTextLabel.text = storyBrain.getStoryText()
        choice1.setTitle(storyBrain.getStoryChoice1(), for: .normal)
        choice2.setTitle(storyBrain.getStoryChoice2(), for: .normal)
    }
}

