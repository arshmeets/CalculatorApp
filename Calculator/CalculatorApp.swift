//
//  CalculatorApp.swift
//  Calculator
//
//  Created by Arshmeet Sodhi on 2020-10-01.
//

import SwiftUI

@main
struct CalculatorApp: App {
    var body: some Scene {
        WindowGroup {
            CalculatorHome()
                .environmentObject(Calculator())
        }
    }
}
