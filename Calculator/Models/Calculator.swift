//
//  Calculator.swift
//  Calculator
//
//  Created by Max Valek on 8/1/23.
//

import Foundation

/// Calculator extension containing ArithmeticExpression struct.
private extension Calculator {
    /// Private helper struct used to store single arithmetic expressions during calculator operation.
    private struct ArithmeticExpression: Equatable {
        /// A decimal value representing the current number in the expression.
        var number: Decimal
        /// Enum value of type ArithmeticOperation indicating the arithmetic operation to be performed
        var operation: OperationButton
        
        /// Evaluates the stored arithmetic expression using the provided secondNumber (current number in the calculator)
        func evaluate(with secondNumber: Decimal) -> Decimal {
            switch operation {
            case .addition:
                return number + secondNumber
            case .subtraction:
                return number - secondNumber
            case .multiplication:
                return number * secondNumber
            case .division:
                return number / secondNumber
            }
        }
    }
}

/// Serves as the model and API for the calculator application. It provides functionality to
/// perform arithmetic operations, handle user input, and display the current state of the calculator.
struct Calculator {
    
    // MARK: - PRIVATE PROPERTIES
    
    /// The current number being entered by the user. (resets several auxiliary properties when set)
    private var currentNumber: Decimal? {
        didSet {
            guard currentNumber != nil else { return }
            isNegative = false
            decimalPressed = false
            zerosTrailingDecimal = 0
            clearPressed = false
        }
    }
    /// The current arithmetic expression being built by the calculator
    private var expression: ArithmeticExpression?
    /// The result of the latest arithmetic expression evaluation
    private var result: Decimal?
    /// Whether the current number should be treated as a negative
    private var isNegative: Bool = false
    /// Whether decimal has been pressed since newNumber was last updated
    private var decimalPressed: Bool = false
    /// Consecutive 0s pressed directly after decimal point pressed
    private var zerosTrailingDecimal: Int = 0
    /// Whether the clear button was pressed.
    private var clearPressed: Bool = false
    /// The current number to display (converted to string and used by view model)
    private var displayedNumber: Decimal? {
        if clearPressed || decimalPressed {
            return currentNumber
        }
        return currentNumber ?? expression?.number ?? result
    }
    /// Whether the current number contains a decimal
    private var containsDecimal: Bool {
        return formattedNumberString(forNumber: displayedNumber).contains(".")
    }
    
    // MARK: - PROPERTIES ACCESSIBLE TO VIEWMODEL
    
    /// String representation of the number to display
    var displayText: String {
        return formattedNumberString(forNumber: displayedNumber, withCommas: true)
    }
    
    /// Whether to show all clear or clear button
    var showAllClear: Bool {
        currentNumber == nil && expression == nil && result == nil || clearPressed
    }
    
    // MARK: - OPERATIONS
    
    /// Add a digit to the number being inputted.
    /// - Parameter digit: the digit button pressed.
    mutating func appendDigit(_ digit: DigitButton) {
        if containsDecimal && digit == .zero {
            zerosTrailingDecimal += 1
        } else if canAddDigit(digit) {
            let numberString = formattedNumberString(forNumber: currentNumber)
            currentNumber = Decimal(string: numberString.appending("\(digit.rawValue)"))
        }
    }
    
    /// Create an ArithmeticExpression and set expression property when an operation is pressed.
    /// - Parameter operation: the operation button pressed
    mutating func setOperation(_ operation: OperationButton) {
        guard var number = currentNumber ?? result else { return }
        if let existingExpression = expression {
            number = existingExpression.evaluate(with: number)
        }
        expression = ArithmeticExpression(number: number, operation: operation)
        currentNumber = nil
    }
    
    /// Toggle between positive and negative (± pressed)
    mutating func negate() {
        /// negate newNumber
        if let number = currentNumber {
            currentNumber = -number
            return
        }
        /// negate result if no newNumber
        if let number = result {
            result = -number
            return
        }
        isNegative.toggle()
    }
    
    /// Convert the number to percentage of 100 (% pressed)
    mutating func convertToPercentage() {
        if let number = currentNumber {
            currentNumber = number / 100
            return
        }
        if let number = result {
            result = number / 100
            return
        }
    }
    
    /// Add a decimal if number doesn't already contain one (decimal pressed)
    mutating func addDecimal() {
        /// if inputted number already has a decimal, return
        if containsDecimal { return }
        decimalPressed = true
    }
    
    /// Evaluate the previously created expression (= pressed)
    mutating func calculateResult() {
        /// make sure a previous expression exists and user has inputted another number
        guard
            let number = currentNumber,
            let expressionToEvaluate = expression
        else { return }
        /// evaluate the expression and store the result in result property
        result = expressionToEvaluate.evaluate(with: number)
        /// reset expression and newNumber properties
        expression = nil
        currentNumber = nil
    }
    
    /// Reset the calculator to its initial state (all clear pressed)
    mutating func reset() {
        currentNumber = nil
        expression = nil
        result = nil
        isNegative = false
        decimalPressed = false
        zerosTrailingDecimal = 0
    }
    
    /// Clear the last entry (clear pressed)
    mutating func clearLastEntry() {
        currentNumber = nil
        isNegative = false
        decimalPressed = false
        zerosTrailingDecimal = 0
        clearPressed = true
    }
    
    // MARK: - HELPERS
    
    /// Get the number as a formatted string.
    private func formattedNumberString(forNumber number: Decimal?, withCommas: Bool = false) -> String {
        var numberString = (withCommas ? number?.formatted(.number) : number.map(String.init)) ?? "0"
        /// negate if isNegative set to true
        if isNegative {
            numberString.insert("-", at: numberString.startIndex)
        }
        /// if decimal pressed since currentNumber last updated
        if decimalPressed {
            numberString.insert(".", at: numberString.endIndex)
        }
        if zerosTrailingDecimal > 0 {
            numberString.append(String(repeating: "0", count: zerosTrailingDecimal))
        }
        
        return numberString
    }
    
    /// Check if the digit can be added.
    /// TRUE if number isnt nil OR digit isn't zero.
    private func canAddDigit(_ digit: DigitButton) -> Bool {
        return displayedNumber != nil || digit != .zero
    }
    
    /// An operation button is highlighted if it was just pressed
    func operationIsHighlighted(_ operation: OperationButton) -> Bool {
        return expression?.operation == operation && currentNumber == nil
    }
}
