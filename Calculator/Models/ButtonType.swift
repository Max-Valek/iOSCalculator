//
//  ButtonType.swift
//  Calculator
//
//  Created by Max Valek on 8/1/23.
//

import Foundation

/*
 ButtonType enum
 
 Numeric buttons encapsulated in the Digit enum.
 Numberic operations encapsulated in ArithmeticOperation enum.
 
 Hashable: for iteration
 CustomStringConvertible: button text
 */
enum ButtonType: Hashable, CustomStringConvertible {
    case digit(_ digit: Digit)
    case operation(_ operation: ArithmeticOperation)
    case negative
    case percent
    case decimal
    case equals
    case allClear
    case clear
    
    var description: String {
        switch self {
        case .digit(let digit):
            return digit.description
        case .operation(let operation):
            return operation.description
        case .negative:
            return "±"
        case .percent:
            return "%"
        case .decimal:
            return "."
        case .equals:
            return "="
        case .allClear:
            return "AC"
        case .clear:
            return "C"
        }
    }
}
