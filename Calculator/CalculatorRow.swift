//
//  CalculatorRow.swift
//  Calculator
//
//  Created by Arshmeet Sodhi on 2020-10-01.
//

import SwiftUI

struct CalculatorRow: View {
    @EnvironmentObject var calculator: Calculator
    var labels = ["", "", "", ""]
    var colors: [Color] = [.gray, .gray, .gray, .orange]
    
    var body: some View {
        // Display a button for each column, selecting from the labels and colors given
        HStack(spacing: 10) {
            ForEach(0..<columnCount) { index in
                CalculatorButton(label: labels[index], color: colors[index])
            }
        }
    }
}

struct CalculatorRow_Previews: PreviewProvider {
    static var previews: some View {
        CalculatorRow(labels: ["1", "2", "3", "+"])
            .previewLayout(.fixed(width: 300, height: 100))
    }
}
