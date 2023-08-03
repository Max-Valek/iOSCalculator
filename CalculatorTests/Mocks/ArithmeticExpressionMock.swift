//
//  ArithmeticExpressionMock.swift
//  CalculatorTests
//
//  Created by Max Valek on 8/3/23.
//

import Foundation
@testable import Calculator

// Arithmetic expression mock for testing
class ArithmeticExpressionMock: ArithmeticExpressionProtocol {
    let number: Decimal
    let operation: OperationButton
    
    init(number: Decimal, operation: OperationButton) {
        self.number = number
        self.operation = operation
    }
    
    var evaluateCalled = false

    // Implement the evaluate method to return a predetermined result
    func evaluate(with secondNumber: Decimal) -> Decimal {
        evaluateCalled = true
        // Return any predetermined value for testing purposes
        return -111.0
    }
}
