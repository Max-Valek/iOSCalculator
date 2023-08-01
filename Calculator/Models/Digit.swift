//
//  Digit.swift
//  Calculator
//
//  Created by Max Valek on 8/1/23.
//

import Foundation

/*
 Enum for digit buttons.
 
 Int type, get its value using rawValue.
 CaseIterable: easily get an ordered array of all cases using .allCases.
 CustomStringConvertible: requires a description property. use this for button text.
 */
enum Digit: Int, CaseIterable, CustomStringConvertible {
    case zero, one, two, three, four, five, six, seven, eight, nine
    
    var description: String {
        "\(rawValue)"
    }
}
