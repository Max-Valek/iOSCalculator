//
//  ArithmeticExpressionMock.swift
//  CalculatorTests
//
//  Created by Max Valek on 8/3/23.
//

import Foundation
@testable import Calculator

// Mock struct conforming to ArithmeticExpressionProtocol
struct ArithmeticExpressionMock: ArithmeticExpressionProtocol {
    let number: Decimal
    let operation: OperationButton

    // Implement the evaluate method to return a predetermined result
    func evaluate(with secondNumber: Decimal) -> Decimal {
        // Return any predetermined value for testing purposes
        return -1.0
    }
}
