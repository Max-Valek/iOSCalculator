//
//  ArithmeticOperation.swift
//  Calculator
//
//  Created by Max Valek on 8/1/23.
//

import Foundation

/*
 Enum for arithmetic operations buttons.
 
 CaseIterable: easily get an ordered array of all cases using .allCases.
 CustomStringConvertible: requires a description property. use this for button text.
 */
enum ArithmeticOperation: CaseIterable, CustomStringConvertible {
    case addition, subtraction, multiplication, division
    
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
