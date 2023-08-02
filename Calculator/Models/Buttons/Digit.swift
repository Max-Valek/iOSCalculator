//
//  Digit.swift
//  Calculator
//
//  Created by Max Valek on 8/1/23.
//

import Foundation

/// Enum for digit buttons (raw values : 0-9)
enum Digit: Int, CaseIterable, CustomStringConvertible {
    case zero, one, two, three, four, five, six, seven, eight, nine
    
    /// Button text (CustomStringConvertible)
    var description: String {
        "\(rawValue)"
    }
}
