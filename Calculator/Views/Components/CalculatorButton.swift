//
//  CalculatorButton.swift
//  Calculator
//
//  Created by Max Valek on 8/1/23.
//

import SwiftUI

/// Only used in CalculatorView, put it in an extension.
extension CalculatorView {
    
    /// View for a calculator button
    struct CalculatorButton: View {
        
        // MARK: - PROPERTIES
        
        /// The ButtonType enum case passed in
        let buttonType: ButtonType
        /// View model instance passed into environment
        @EnvironmentObject private var viewModel: ViewModel
        
        // MARK: - BODY
        
        var body: some View {
            Button(buttonType.description) {
                viewModel.performAction(for: buttonType)
            }
                .buttonStyle(CalculatorButtonStyle(
                    size: viewModel.getButtonSize(),
                    backgroundColor: viewModel.getBackgroundColor(for: buttonType),
                    foregroundColor: viewModel.getForegroundColor(for: buttonType),
                    isWide: buttonType == .digit(.zero))
                )
        }
    }
}

// MARK: - PREVIEWS

struct CalculatorView_CalculatorButton_Previews: PreviewProvider {
    static var previews: some View {
        CalculatorView.CalculatorButton(buttonType: .digit(.five))
            .environmentObject(CalculatorView.ViewModel())
    }
}
