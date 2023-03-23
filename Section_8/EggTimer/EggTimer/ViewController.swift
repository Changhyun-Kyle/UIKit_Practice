//
//  ViewController.swift
//  EggTimer
//
//  Created by 강창현 on 2023/03/23.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var progressBar: UIProgressView!
    
    let eggTimes = ["Soft": 3, "Medium": 4, "Hard": 7]
    var timer = Timer()
    var totalTime: Int = 0
    var secondsPassed: Int = 0
    
    var player: AVAudioPlayer!

    /*
     let softTime: Int = 5
     let mediumTime: Int = 7
     let hardTime: Int = 12
     */
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func hardnessSelected(_ sender: UIButton) {
        progressBar.progress = 0.0
        timer.invalidate()
        totalTime = 0
        secondsPassed = 0
        
        let hardness = sender.currentTitle! // Soft, Medium, Hard
        titleLabel.text = hardness
        totalTime = eggTimes[hardness]!
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateCounter), userInfo: nil, repeats: true)
        /*
         switch hardness {
         case "Soft":
         print(eggTimes["Soft"])
         case "Medium":
         print(eggTimes["Medium"])
         case "Hard":
         print(eggTimes["Hard"])
         default:
         print("Error")
         }
         
         
         if hardness == "Soft" {
         print(softTime)
         } else if hardness == "Medium" {
         print(mediumTime)
         } else {
         print(hardTime)
         }
         */
    }
    @objc func updateCounter() {
        //example functionality
        if secondsPassed < totalTime {
            secondsPassed += 1
            progressBar.progress = Float(secondsPassed) / Float(totalTime)
        } else {
            timer.invalidate()
            playSound()
            titleLabel.text = "완료!"
        }
    }
    func playSound() {
        let url = Bundle.main.url(forResource: "alarm_sound", withExtension: "mp3")
        player = try! AVAudioPlayer(contentsOf: url!)
        player.play()
    }
}
