//
//  CalculatorViewModel.swift
//  Calculator
//
//  Created by Max Valek on 8/1/23.
//

import SwiftUI

/// ViewModel only accessed in CalculatorView, put it in an extension.
extension CalculatorView {
    
    final class ViewModel: ObservableObject {
        
        // MARK: - PROPERTIES
        
        /// Instance of calculator model/API
        @Published private var calculator = Calculator()
        
        /// Number displayed above buttons
        var displayText: String {
            return calculator.displayText
        }
        
        /// Calculator buttons matrix
        var buttons: [[ButtonType]] {
            let clearType: ButtonType = calculator.showAllClear ? .allClear : .clear
            return [
                [clearType, .negative, .percent, .operation(.division)],
                [.digit(.seven), .digit(.eight), .digit(.nine), .operation(.multiplication)],
                [.digit(.four), .digit(.five), .digit(.six), .operation(.subtraction)],
                [.digit(.one), .digit(.two), .digit(.three), .operation(.addition)],
                [.digit(.zero), .decimal, .equals]
            ]
        }
        
        /// Size of calculator buttons
        var buttonSize: CGFloat = 0.0
        
        init() {
            self.buttonSize = getButtonSize()
        }
        
        // MARK: - ACTIONS
        
        /// Perform associated Calculator function when a button is pressed
        func performAction(for buttonType: ButtonType) {
            switch buttonType {
            case .digit(let digit):
                calculator.appendDigit(digit)
            case .operation(let operation):
                calculator.setOperation(operation)
            case .negative:
                calculator.negate()
            case .percent:
                calculator.convertToPercentage()
            case .decimal:
                calculator.addDecimal()
            case .equals:
                calculator.calculateResult()
            case .allClear:
                calculator.reset()
            case .clear:
                calculator.clearLastEntry()
            }
        }
        
        // MARK: - HELPERS
        
        /// Return true if the provided operation button should be highlighted (user just pressed it)
        func buttonIsHighlighted(buttonType: ButtonType) -> Bool {
            guard case .operation(let operation) = buttonType else { return false }
            return calculator.operationIsHighlighted(operation)
        }
        
        // MARK: - CALCULATORBUTTON FUNCTIONS
        
        func getButtonSize() -> CGFloat {
            let screenWidth = UIScreen.main.bounds.width
            let spacingCount = Constants.buttonsPerRow + 1
            return (screenWidth - (spacingCount * Constants.padding)) / Constants.buttonsPerRow
        }
        
        /// Get a button's background color. (foreground color if button highlighted)
        func getBackgroundColor(for buttonType: ButtonType) -> Color {
            return buttonIsHighlighted(buttonType: buttonType) ? buttonType.foregroundColor : buttonType.backgroundColor
        }
        
        /// Get a button's foreground color. (background color if button highlighted)
        func getForegroundColor(for buttonType: ButtonType) -> Color {
            return buttonIsHighlighted(buttonType: buttonType) ? buttonType.backgroundColor : buttonType.foregroundColor
        }
    }
}
