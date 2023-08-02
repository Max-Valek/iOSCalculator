//
//  CalculatorViewModel.swift
//  Calculator
//
//  Created by Max Valek on 8/1/23.
//

import Foundation
import Combine

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
    }
}
