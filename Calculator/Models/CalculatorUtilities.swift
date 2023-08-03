//
//  CalculatorUtilities.swift
//  Calculator
//
//  Created by Max Valek on 8/3/23.
//

import Foundation

/// Global utility functions for Calculator for reusability and testability.

/// Helper function to get the number as a formatted string.
func formattedNumberString(forNumber number: Decimal?, isNegative: Bool,
                           decimalPressed: Bool, zerosTrailingDecimal: Int,
                           withCommas: Bool = false) -> String {
    /// inputted number as a string
    var numberString = (withCommas ? number?.formatted(.number) : number.map(String.init)) ?? "0"
    /// add '-' to beginning if number is negative
    if isNegative {
        numberString.insert("-", at: numberString.startIndex)
    }
    /// add '.' to the end for decimals
    if decimalPressed {
        numberString.insert(".", at: numberString.endIndex)
    }
    /// add additional zeros
    if zerosTrailingDecimal > 0 {
        numberString.append(String(repeating: "0", count: zerosTrailingDecimal))
    }

    return numberString
}
