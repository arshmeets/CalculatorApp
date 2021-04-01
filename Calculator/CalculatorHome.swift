//
//  ContentView.swift
//  Calculator
//
//  Created by Arshmeet Sodhi on 2020-10-01.
//

import SwiftUI

// The number of columns and rows of buttons in the calculator
let columnCount = 4
let rowCount = 5

// Custom colors
let darkerGray = Color(CGColor(gray: 0.1, alpha: 1))
let darkGray = Color(CGColor(gray: 0.3, alpha: 1))

struct CalculatorHome: View {
    @EnvironmentObject var calculator: Calculator
    
    var body: some View {
        VStack(alignment: .trailing, spacing: 0) {
            
            // Display the current value at the top
            Text(calculator.displayValue)
                .foregroundColor(.white)
                .padding(.trailing)
                .font(.system(size: 40))
                .lineLimit(1)
                .padding(.leading, 20)
                .padding(.trailing, 20)
            
            // Display five rows of buttons, each with labels specified
            VStack(spacing: 0) {
                
                CalculatorRow(labels: ["CE", "", "", String("\u{00f7}")], colors: [darkGray, darkGray, darkGray, .orange])
                
                CalculatorRow(labels: ["7", "8", "9", String("\u{00d7}")])
                
                CalculatorRow(labels: ["4", "5", "6", "-"])
                
                CalculatorRow(labels: ["1", "2", "3", "+"])
                
                CalculatorRow(labels: ["0", ".", "", "="])
            }
            .padding()
        }
        .padding(.top, 200)
        .background(darkerGray)
        .edgesIgnoringSafeArea(.all)
    }
}

struct CalculatorHome_Previews: PreviewProvider {
    static var previews: some View {
        CalculatorHome()
            .environmentObject(Calculator())
    }
}
