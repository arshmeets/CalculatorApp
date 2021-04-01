//
//  Calculator.swift
//  Calculator
//
//  Created by Arshmeet Sodhi on 2020-10-01.
//

import Foundation

func pow(_ base: Int, _ exp: Int) -> Double {
    return pow(Double(base), Double(exp))
}

class Calculator: ObservableObject {
    
    @Published var displayValue = "0"
    
    var currentOp: Operator?
    var currentNumber: Double? = 0
    var previousNumber: Double?
    var equaled = false
    var decimalPlace = 0
    
    /// Selects the appropriate function based on the label of the button pressed
    func buttonPressed(label: String) {
        
        if label == "CE" {
            // Clear the calculator
            displayValue = "0"
            reset()
            
        } else if label == "=" {
            equalClicked()
            
        } else if label == "." {
            decimalClicked()
            
        } else if let value = Double(label) {
            numberClicked(value: value)
            
        } else {
            operatorClicked(op: Operator(label))

        }
        
    }
    
    private func equalClicked() {
        
        // Check if we have an operation to perform
        if currentOp != nil {
            
            // Reset the decimal place for the current number
            decimalPlace = 0
            
            // Guard for division by 0
            if currentOp!.isDivision && (currentNumber == nil && previousNumber == 0 || currentNumber == 0) {
                displayValue = "Error"
                reset()
                return
            }
            
            // Check if we have at least one operand. Otherwise something went wrong, do nothing
            if currentNumber != nil || previousNumber != nil {
                
                // Comput the total
                let total = currentOp!.op(previousNumber ?? currentNumber!, currentNumber ?? previousNumber!)
                
                // Update the first operand
                if currentNumber == nil {
                    currentNumber = previousNumber
                }
                
                // Update the second operand
                previousNumber = total
                
                // Set equaled flag
                equaled = true
                
                // Update the UI
                setDisplayValue(number: total)
            }
            
        }
    }
    
    private func decimalClicked() {
        
        // If the equal was pressed, we clear the current numbers for future typing
        if equaled {
            currentNumber = nil
            previousNumber = nil
            equaled = false
        }
        
        // If the user started typing with a ".", set the current value to 0
        if currentNumber == nil {
            currentNumber = 0
        }
        
        // Set the decimal place to 1
        decimalPlace = 1
        
        // Update the UI
        setDisplayValue(number: currentNumber!)
        displayValue.append(".")
    }
    
    private func numberClicked(value: Double) {
        
        // If the equal was pressed, we clear the current numbers for future typing
        if equaled {
            currentNumber = nil
            previousNumber = nil
            equaled = false
        }
        
        // If there is no number currently, set it to the value
        if currentNumber == nil {
            currentNumber = value / pow(10, decimalPlace)
            
        // Otherwise, add the value to the current number
        } else {
            // If no decimal was typed, add the value as the last digit of the current number
            if decimalPlace == 0 {
                currentNumber = currentNumber! * 10 + value
                
            // Otherwise, we add the value as the last decimal of the number
            } else {
                currentNumber = currentNumber! + value / pow(10, decimalPlace)
                decimalPlace += 1
            }
        }
        
        // Update the UI
        setDisplayValue(number: currentNumber!)
    }
    
    private func operatorClicked(op: Operator) {
        // Reset the decimal
        decimalPlace = 0
        
        // If the previous operation was equaled, reset the current number
        if equaled {
            currentNumber = nil
            equaled = false
        }
        
        // If we already have two operands, compute them to make room for the next
        if currentNumber != nil && previousNumber != nil {
            let total = currentOp!.op(previousNumber!, currentNumber!)
            previousNumber = total
            currentNumber = nil
            
            setDisplayValue(number: total)
            
        // If only one number has been given, move it into the second operand
        } else if previousNumber == nil {
            previousNumber = currentNumber
            currentNumber = nil
        }
        
        // Set the operator
        currentOp = op
    }
    
    // Displays the number nicely formatted
    private func setDisplayValue(number: Double) {
        
        // Don't display a decimal if the number is an integer
        if number == floor(number) {
            displayValue = "\(Int(number))"
            
        // Otherwise, display the decimal
        } else {
            let decimalPlaces = 10
            displayValue = "\(round(pow(10, decimalPlaces) * number) / pow(10, decimalPlaces))"
        }
        
    }
    
    // Resets the calculator
    private func reset() {
        currentOp = nil
        currentNumber = 0
        previousNumber = nil
        equaled = false
        decimalPlace = 0
    }
    
}
