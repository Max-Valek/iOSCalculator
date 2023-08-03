//
//  ArithmeticExpression.swift
//  Calculator
//
//  Created by Max Valek on 8/3/23.
//

import Foundation

// MARK: - PROTOCOL

/// Protocol for the arithmetic expression used in calculator operation.
protocol ArithmeticExpressionProtocol {
    var number: Decimal { get }
    var operation: OperationButton { get }
    
    func evaluate(with secondNumber: Decimal) -> Decimal
}

// MARK: - STRUCT

/// The concrete implementation of ArithmeticExpression conforming to the protocol.
struct ArithmeticExpression: ArithmeticExpressionProtocol, Equatable {
    var number: Decimal
    var operation: OperationButton
    
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
