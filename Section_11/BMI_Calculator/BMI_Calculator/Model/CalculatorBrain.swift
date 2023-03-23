//
//  CalculatorBrain.swift
//  BMI_Calculator
//
//  Created by 강창현 on 2023/03/23.
//

import Foundation

struct CalculatorBrain {
    
    var bmi: Float?
    
    func getBMIValue() -> String {
        let bmiToDecimalValue = String(format: "%.1f", bmi)
        return bmiToDecimalValue
    }
    
    mutating func caculateBMI(height: Float, weight: Float) {
        let bmiValue = weight / pow(height, 2)
        bmi = bmiValue
    }
}
