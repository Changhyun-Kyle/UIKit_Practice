//
//  ViewController.swift
//  BMI_Calculator
//
//  Created by 강창현 on 2023/03/23.
//

import UIKit

class CalculateViewController: UIViewController {

    @IBOutlet weak var heightLabel: UILabel!
    @IBOutlet weak var weightLabel: UILabel!
    @IBOutlet weak var heightSilder: UISlider!
    @IBOutlet weak var weightSlider: UISlider!
    
    var calculatorBrain = CalculatorBrain()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func slideHeightSilder(_ sender: UISlider) {
        let height = String(format: "%.2f", sender.value)
        heightLabel.text = "\(height)m"
    }
    
    @IBAction func slideWeightSilder(_ sender: UISlider) {
        let weight = String(Int(sender.value))
        weightLabel.text = "\(weight)KG"
        // print(String(format: "%.f", sender.value))
    }
    
    
    @IBAction func calculatePressed(_ sender: UIButton) {
        let height = heightSilder.value
        let weight = weightSlider.value
        
        calculatorBrain.caculateBMI(height: height, weight: weight)
        self.performSegue(withIdentifier: "goToResult", sender: self)
        
        // MARK: - Present 활용한 Navigation
        // let secondVC = SecondViewController()
        // secondVC.bmiValue = String(format: "%.1f", bmi)
        
        // self.present(secondVC, animated: true, completion: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToResult" {
            let destinationVC = segue.destination as! ResultViewController
            destinationVC.bmiValue = calculatorBrain.getBMIValue()
            
        }
    }
}

