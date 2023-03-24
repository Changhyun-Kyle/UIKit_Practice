//
//  ViewController.swift
//  Tipsy
//
//  Created by 강창현 on 2023/03/24.
//

import UIKit

class CalculatorViewController: UIViewController {

    @IBOutlet weak private var billTextField: UITextField!
    @IBOutlet weak private var zeroPctButton: UIButton!
    @IBOutlet weak private var tenPctButton: UIButton!
    @IBOutlet weak private var twentyPctButton: UIButton!
    @IBOutlet weak private var splitNumberLabel: UILabel!
    
    var tipBrain = TipBrain()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func tipChanged(_ sender: UIButton) {
        billTextField.endEditing(true)
        zeroPctButton.isSelected = false
        tenPctButton.isSelected = false
        twentyPctButton.isSelected = false
        sender.isSelected = true
        
        let buttonTitle = sender.currentTitle!   
        tipBrain.convertButtonTitleAsNumber(buttonTitle)
    }
    
    @IBAction func textFieldPressed(_ sender: UITextField) {
        sender.text = ""
    }
    
    @IBAction func stepperValueChanged(_ sender: UIStepper) {
        splitNumberLabel.text = String(format: "%.f", sender.value)
        tipBrain.convertSplitsToInt(sender.value)
    }
    
    @IBAction func calculatorPressed(_ sender: UIButton) {
        if billTextField.text != "" {
            let bill = billTextField.text ?? "Please input total bills"
            tipBrain.calculateTotalBill(bill)
            self.performSegue(withIdentifier: "goToResult", sender: self)
        } else {
            billTextField.text = "Please input total bills"
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToResult" {
            
            let destinationVC = segue.destination as! ResultsViewController
            destinationVC.calculatedTotalBill = tipBrain.getCalculateResult() ?? "Cannot Calculate"
            destinationVC.splits = tipBrain.getSplits()
            destinationVC.tip = tipBrain.getTip()
        }
    }
}

