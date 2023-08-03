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
    
    /// Calculator instance injected into ViewModel
    private var calculator: CalculatorProtocol = Calculator()
    
    var body: some Scene {
        WindowGroup {
            /// Inject the ViewModel into the environment with the Calculator instance
            CalculatorView()
                .environmentObject(CalculatorView.ViewModel(calculator: calculator))
        }
    }
}
