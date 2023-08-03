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
        
        /// Instance of calculator model (API)
        //@Published private var calculator = Calculator()
        
        @Published private var calculator: CalculatorProtocol
        /// Size of calculator buttons
        var buttonSize: CGFloat = 0.0
        
        init(calculator: CalculatorProtocol = Calculator()) {
            self.calculator = calculator
            self.buttonSize = getButtonSize()
        }
        
        /// Stringified number to display above buttons.
        var displayText: String {
            return calculator.displayText
        }
        /// Calculator buttons matrix.
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
        
        // MARK: - ACTIONS
        
        /// Perform associated Calculator function when a button is pressed
        func performAction(for buttonType: ButtonType) {
            switch buttonType {
            case .digit(let digit):
                calculator.appendDigit(digit)           /// append value for digit pressed to displayed number
            case .operation(let operation):
                calculator.setOperation(operation)      /// create expression with number and operation
            case .negative:
                calculator.negate()                     /// toggle positive/negative
            case .percent:
                calculator.convertToPercentage()        /// divide number by 100
            case .decimal:
                calculator.addDecimal()                 /// append a decimal point (if allowed)
            case .equals:
                calculator.calculateResult()            /// evaluate an expression
            case .allClear:
                calculator.reset()                      /// reset calculator to defaults
            case .clear:
                calculator.clearLastEntry()             /// clear the last entry
            }
        }
        
        // MARK: - CALCULATORBUTTON FUNCTIONS
        
        /// Calculate the size for one button using screen size
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
        
        // MARK: - HELPERS
        
        /// Return true if the provided operation button should be highlighted (user just pressed it)
        func buttonIsHighlighted(buttonType: ButtonType) -> Bool {
            guard case .operation(let operation) = buttonType else { return false }
            return calculator.operationIsHighlighted(operation)
        }
    }
}
