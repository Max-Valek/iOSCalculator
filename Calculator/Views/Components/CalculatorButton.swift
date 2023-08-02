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
                    size: getButtonSize(),
                    backgroundColor: getBackgroundColor(),
                    foregroundColor: getForegroundColor(),
                    isWide: buttonType == .digit(.zero))
                )
        }
        
        // MARK: - FUNCTIONS
        
        /// Calculate and return the size for a button using screen bounds.
        private func getButtonSize() -> CGFloat {
            let screenWidth = UIScreen.main.bounds.width
            let buttonCount: CGFloat = 4.0
            let spacingCount = buttonCount + 1
            return (screenWidth - (spacingCount * Constants.padding)) / buttonCount
        }
        
        /// Get a button's background color. (foreground color if button highlighted)
        private func getBackgroundColor() -> Color {
            return viewModel.buttonIsHighlighted(buttonType: buttonType) ? buttonType.foregroundColor : buttonType.backgroundColor
        }
        
        /// Get a button's foreground color. (background color if button highlighted)
        private func getForegroundColor() -> Color {
            return viewModel.buttonIsHighlighted(buttonType: buttonType) ? buttonType.backgroundColor : buttonType.foregroundColor
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
