//
//  ViewController.swift
//  Section_4
//
//  Created by 강창현 on 2023/03/14.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var diceImageView1: UIImageView!
    @IBOutlet weak var diceImageView2: UIImageView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    @IBAction func rollButtonPressed(_ sender: UIButton) {
        
        let randomLeftNumber: Int = Int.random(in: 0...5)
        let randomRightNumber: Int = Int.random(in: 0...5)
        
        let diceImages = [
            UIImage(named: "DiceOne"),
            UIImage(named: "DiceTwo"),
            UIImage(named: "DiceThree"),
            UIImage(named: "DiceFour"),
            UIImage(named: "DiceFive"),
            UIImage(named: "DiceSix")]
        
        diceImageView1.image = diceImages[randomLeftNumber]
        diceImageView2.image = diceImages[randomRightNumber]
    }
}

