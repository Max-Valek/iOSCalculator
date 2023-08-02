//
//  Digit.swift
//  Calculator
//
//  Created by Max Valek on 8/1/23.
//

import Foundation

/// Enumeration representing digit buttons (0-9)
enum DigitButton: Int, CaseIterable, CustomStringConvertible {
    /// raw values are 0, 1, 2,..., 8, 9
    case zero, one, two, three, four, five, six, seven, eight, nine
    
    /// The button's text label (rawValue as a string).
    var description: String {
        "\(rawValue)"
    }
}
