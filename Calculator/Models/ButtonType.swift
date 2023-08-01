//
//  ButtonType.swift
//  Calculator
//
//  Created by Max Valek on 8/1/23.
//

import Foundation

/*
 ButtonType enum
 
 Numeric buttons encapsulated in the Digit enum
 Numberic operations encapsulated in ArithmeticOperation enum
 */
enum ButtonType {
    case digit(_ digit: Digit)
    case operation(_ operation: ArithmeticOperation)
    case negative
    case percent
    case decimal
    case equals
    case allClear
    case clear
}
