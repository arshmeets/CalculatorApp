//
//  Operator.swift
//  Calculator
//
//  Created by Arshmeet Sodhi on 2020-10-01.
//

import Foundation

class Operator {
    
    var op: (Double, Double) -> Double
    var isDivision = false
    
    init(_ string: String) {
        
        if string == "+" {
            self.op = (+)
            
        } else if string == "-" {
            self.op = (-)
            
        } else if string == String("\u{00f7}") {
            self.op = (/)
            self.isDivision = true
            
        } else {
            self.op = (*)
            
        }
    }
    
}
