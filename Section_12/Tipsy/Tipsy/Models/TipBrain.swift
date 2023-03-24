//
//  TipBrain.swift
//  Tipsy
//
//  Created by 강창현 on 2023/03/24.
//

import UIKit

struct TipBrain {
    
    var totalBill: Double = 0.0
    var calculatedTotalBill: String = "0.0"
    var splits: Int = 2
    var tip: Double = 0.0
    
    /*
     struct Tip {
         var totalBill: Double
         var calculatedTotalBill: String
         var splits: Int
         var tip: Double
     }
     */
    mutating func convertButtonTitleAsNumber(_ title: String) {
        let buttonTitleRemovePercentSign = String(title.dropLast())
        let buttonTitleAsNumber = Double(buttonTitleRemovePercentSign)!
        tip = buttonTitleAsNumber / 100
    }
    
    mutating func convertSplitsToInt(_ value: Double) {
        splits = Int(value)
    }
    
    mutating func calculateTotalBill(_ bill: String) {
        guard let totalBill =  Double(bill) else { return }
        let result = totalBill * (1 + tip) / Double(splits)
        calculatedTotalBill = String(format: "%.2f", result)
    }
    
    func getSplits() -> Int {
        return splits
    }
    
    func getTip() -> Int {
        return Int(tip * 100)
    }
    
    func getCalculateResult() -> String? {
        return calculatedTotalBill
    }
}
