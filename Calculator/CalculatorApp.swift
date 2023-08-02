//
//  CalculatorApp.swift
//  Calculator
//
//  Created by Max Valek on 8/1/23.
//

import SwiftUI

/// Entrypoint for the application.
@main
struct CalculatorApp: App {
    
    var body: some Scene {
        WindowGroup {
            CalculatorView()
                /// Pass ViewModel instance into environment.
                .environmentObject(CalculatorView.ViewModel())
        }
    }
}
