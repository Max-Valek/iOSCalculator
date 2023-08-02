//
//  CalculatorApp.swift
//  Calculator
//
//  Created by Max Valek on 8/1/23.
//

import SwiftUI

@main
struct CalculatorApp: App {
    var body: some Scene {
        WindowGroup {
            CalculatorView()
                .environmentObject(CalculatorView.ViewModel())      // pass instance of ViewModel as environment object
        }
    }
}
