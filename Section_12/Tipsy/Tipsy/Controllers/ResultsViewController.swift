//
//  ResultsViewController.swift
//  Tipsy
//
//  Created by 강창현 on 2023/03/24.
//

import UIKit

class ResultsViewController: UIViewController {

    @IBOutlet weak var totalLabel: UILabel!
    @IBOutlet weak var settingLabel: UILabel!
    
    var calculatedTotalBill = "0.0"
    var splits: Int = 2
    var tip : Int = 2
    
    override func viewDidLoad() {
        super.viewDidLoad()
        totalLabel.text = calculatedTotalBill
        settingLabel.text = "Split between \(splits) people, with \(tip)% tip."
        
    }
    
    @IBAction func recalculatePressed(_ sender: UIButton) {
        self.dismiss(animated: true)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
