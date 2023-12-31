//
//  CalculatorMock.swift
//  CalculatorTests
//
//  Created by Max Valek on 8/3/23.
//

import Foundation
@testable import Calculator

/// Calculator mock for testing
class CalculatorMock: CalculatorProtocol {
    
    var displayText: String
    var showAllClear: Bool
    
    init(displayText: String, showAllClear: Bool) {
        self.displayText = displayText
        self.showAllClear = showAllClear
    }
    
    /// Keep track of whether the functions were called.
    var appendDigitCalled = false
    var setOperationCalled = false
    var negateCalled = false
    var convertToPercentageCalled = false
    var addDecimalCalled = false
    var calculateResultCalled = false
    var resetCalled = false
    var clearLastEntryCalled = false
    
    func appendDigit(_ digit: DigitButton) {
        appendDigitCalled = true
    }
    
    func setOperation(_ operation: OperationButton) {
        setOperationCalled = true
    }
    
    func negate() {
        negateCalled = true
    }
    
    func convertToPercentage() {
        convertToPercentageCalled = true
    }
    
    func addDecimal() {
        addDecimalCalled = true
    }
    
    func calculateResult() {
        calculateResultCalled = true
    }
    
    func reset() {
        resetCalled = true
    }
    
    func clearLastEntry() {
        clearLastEntryCalled = true
    }
    
    func operationIsHighlighted(_ operation: OperationButton) -> Bool {
        return true
    }
}
