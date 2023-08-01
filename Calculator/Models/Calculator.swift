//
//  Calculator.swift
//  Calculator
//
//  Created by Max Valek on 8/1/23.
//

import Foundation

/// Serves as the model and API for the calculator application. It provides functionality to
/// perform arithmetic operations, handle user input, and display the current state of the calculator.
struct Calculator {
    
    /// Private helper struct used to store single arithmetic expressions during calculator operation.
    private struct ArithmeticExpression: Equatable {
        /// A decimal value representing the current number in the expression.
        var number: Decimal
        /// Enum value of type ArithmeticOperation indicating the arithmetic operation to be performed
        var operation: ArithmeticOperation
        
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
    
    // MARK: - PROPERTIES
    
    /// The current number being entered by the user. (resets several auxiliary properties when set)
    private var newNumber: Decimal? {
        didSet {
            guard newNumber != nil else { return }
            carryingNegative = false
            carryingDecimal = false
            carryingZeroCount = 0
            pressedClear = false
        }
    }
    /// The current arithmetic expression being built by the calculator
    private var expression: ArithmeticExpression?
    /// The result of the latest arithmetic expression evaluation
    private var result: Decimal?
    
    /// Whether the current number should be treated as a negative
    private var carryingNegative: Bool = false
    /// Whether the current number contains a decimal point (to avoid multiple)
    private var carryingDecimal: Bool = false
    /// The count of consecutive 0s that follow the decimal point (for handling trailing 0s)
    private var carryingZeroCount: Int = 0
    
    /// Whether the clear button has been pressed.
    private var pressedClear: Bool = false
    
    // MARK: - COMPUTED PROPERTIES
    
    /// Number currently being displayed, as a string
    var displayText: String {
        return getNumberString(forNumber: number, withCommas: true)
    }
    
    /// Whether to show all clear or clear button
    var showAllClear: Bool {
        newNumber == nil && expression == nil && result == nil || pressedClear
    }
    
    /// The current number used for calculation and display.
    /// If the user is currently entering a new number or a decimal point, it returns newNumber
    /// Otherwise, it returns result if available, or the number from the active expression.
    var number: Decimal? {
        if pressedClear || carryingDecimal {
            return newNumber
        }
        return newNumber ?? expression?.number ?? result
    }
    
    /// if the current number contains a decimal
    private var containsDecimal: Bool {
        return getNumberString(forNumber: number).contains(".")
    }
    
    // MARK: - OPERATIONS
    
    /// Add a digit to newNumber
    /// - Parameter digit: the digit button pressed
    mutating func setDigit(_ digit: Digit) {
        if containsDecimal && digit == .zero {
            carryingZeroCount += 1
        } else if canAddDigit(digit) {
            let numberString = getNumberString(forNumber: newNumber)
            newNumber = Decimal(string: numberString.appending("\(digit.rawValue)"))
        }
    }
    
    /// Create an ArithmeticExpression when an operation is pressed
    /// - Parameter operation: the operation button pressed
    mutating func setOperation(_ operation: ArithmeticOperation) {
        guard var number = newNumber ?? result else { return }
        if let existingExpression = expression {
            number = existingExpression.evaluate(with: number)
        }
        expression = ArithmeticExpression(number: number, operation: operation)
        newNumber = nil
    }
    
    /// Toggle between positive and negative
    mutating func toggleSign() {
        if let number = newNumber {
            newNumber = -number
            return
        }
        if let number = result {
            result = -number
            return
        }
        carryingNegative.toggle()
    }
    
    /// Get the number as a percentage
    mutating func setPercent() {
        if let number = newNumber {
            newNumber = number / 100
            return
        }
        if let number = result {
            result = number / 100
            return
        }
    }
    
    /// Add a decimal
    mutating func setDecimal() {
        if containsDecimal { return }
        carryingDecimal = true
    }
    
    /// Evaluate the expression
    mutating func evaluate() {
        guard let number = newNumber, let expressionToEvaluate = expression else { return }
        result = expressionToEvaluate.evaluate(with: number)
        expression = nil
        newNumber = nil
    }
    
    /// All clear pressed (reset everything)
    mutating func allClear() {
        newNumber = nil
        expression = nil
        result = nil
        carryingNegative = false
        carryingDecimal = false
        carryingZeroCount = 0
    }
    
    /// Clear pressed (reset the last entry)
    mutating func clear() {
        newNumber = nil
        carryingNegative = false
        carryingDecimal = false
        carryingZeroCount = 0
        pressedClear = true
    }
    
    // MARK: - HELPERS
    
    /// An operation button is highlighted if it was just pressed
    func operationIsHighlighted(_ operation: ArithmeticOperation) -> Bool {
        return expression?.operation == operation && newNumber == nil
    }
    
    /// Get number as a string
    private func getNumberString(forNumber number: Decimal?, withCommas: Bool = false) -> String {
        var numberString = (withCommas ? number?.formatted(.number) : number.map(String.init)) ?? "0"
        
        if carryingNegative {
            numberString.insert("-", at: numberString.startIndex)
        }
        
        if carryingDecimal {
            numberString.insert(".", at: numberString.endIndex)
        }
        
        if carryingZeroCount > 0 {
            numberString.append(String(repeating: "0", count: carryingZeroCount))
        }
        
        return numberString
    }
    
    /// Check if the digit can be added
    private func canAddDigit(_ digit: Digit) -> Bool {
        return number != nil || digit != .zero
    }
}
