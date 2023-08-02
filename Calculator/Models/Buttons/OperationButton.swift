//
//  ArithmeticOperation.swift
//  Calculator
//
//  Created by Max Valek on 8/1/23.
//

import Foundation

/// Enumeration representing arithmetic operations (+, -, x, ÷)
enum OperationButton: CaseIterable, CustomStringConvertible {
    case addition, subtraction, multiplication, division
    
    /// The button's text label.
    var description: String {
        switch self {
        case .addition: return "+"
        case .subtraction: return "-"
        case .multiplication: return "x"
        case .division: return "÷"
        }
    }
}
