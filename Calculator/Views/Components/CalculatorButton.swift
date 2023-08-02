//
//  CalculatorButton.swift
//  Calculator
//
//  Created by Max Valek on 8/1/23.
//

import SwiftUI

/// Only used in CalculatorView, put it in an extension.
extension CalculatorView {
    
    /// View for a singular calculator button.
    struct CalculatorButton: View {
        
        // MARK: - PROPERTIES
        
        /// The ButtonType enum case passed in
        let button: ButtonType
        /// View model instance passed into environment
        @EnvironmentObject private var viewModel: ViewModel
        
        // MARK: - BODY
        
        var body: some View {
            /// Title: button description
            /// Action: perform the action associated with the specific button
            Button(button.description) {
                viewModel.performAction(for: button)
            }
                /// Apply custom button style
                .buttonStyle(CalculatorButtonStyle(
                    size: viewModel.getButtonSize(),
                    backgroundColor: viewModel.getBackgroundColor(for: button),
                    foregroundColor: viewModel.getForegroundColor(for: button),
                    isWide: button == .digit(.zero))
                )
        }
    }
}

// MARK: - PREVIEWS

struct CalculatorView_CalculatorButton_Previews: PreviewProvider {
    static var previews: some View {
        CalculatorView.CalculatorButton(button: .digit(.five))
            .environmentObject(CalculatorView.ViewModel())
    }
}
