//
//  CalculatorBrain.swift
//  BMI_Calculator
//
//  Created by 강창현 on 2023/03/23.
//

import UIKit

struct CalculatorBrain {
    
    var bmi: BMI?
    
    func getBMIValue() -> String {
        // MARK: - Nil Coalescing Operator
        let bmiToDecimalValue = String(format: "%.1f", bmi?.value ?? 0.0)
        return bmiToDecimalValue
        // MARK: - Optional Binding
        /*
         if let safeBMI = bmi {
         let bmiToDecimalValue = String(format: "%.1f", safeBMI)
         return bmiToDecimalValue
         } else {
         return "0.0"
         }
         */
        // MARK: - Chek for nil Value with Force Unwrapping
        /*
         if bmi != nil {
         let bmiToDecimalValue = String(format: "%.1f", bmi!)
         return bmiToDecimalValue
         } else {
         return "0.0"
         }
         */
    }
    
    func getAdvice() -> String {
        return bmi?.advice ?? "No advice"
    }
    
    func getColor() -> UIColor {
        return bmi?.color ?? UIColor.white
    }
    mutating func caculateBMI(height: Float, weight: Float) {
        let bmiValue = weight / pow(height, 2)
        
        if bmiValue < 18.5 {
            print("Underweight")
            bmi = BMI(value: bmiValue, advice: "Eat more pies!", color: UIColor.blue)
        } else if bmiValue < 24.9 {
            print("Normal")
            bmi = BMI(value: bmiValue, advice: "Fit as a fiddle!", color: UIColor.green)
        } else {
            print("Overweight")
            bmi = BMI(value: bmiValue, advice: "Eat less pies", color: UIColor.red)
        }
    }
}
