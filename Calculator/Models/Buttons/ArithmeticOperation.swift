//
//  ArithmeticOperation.swift
//  Calculator
//
//  Created by Max Valek on 8/1/23.
//

import Foundation

/// Enum for arithmetic operations (+, -, x, ÷)
enum ArithmeticOperation: CaseIterable, CustomStringConvertible {
    case addition, subtraction, multiplication, division
    
    /// Button text (CustomStringConvertible)
    var description: String {
        switch self {
        case .addition:
            return "+"
        case .subtraction:
            return "-"
        case .multiplication:
            return "x"
        case .division:
            return "÷"
        }
    }
}
