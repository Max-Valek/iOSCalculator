//
//  ButtonType.swift
//  Calculator
//
//  Created by Max Valek on 8/1/23.
//

import Foundation
import SwiftUI

// MARK: - BUTTON TYPE

/// Enumeration representing different types of calculator buttons.
enum ButtonType: Hashable, CustomStringConvertible {
    
    /// Represents digit buttons with associated DigitButton values.
    case digit(_ digit: DigitButton)
    /// Represents arithmetic operation buttons with associated OperationButton values.
    case operation(_ operation: OperationButton)
    /// ±, %, ., =, AC, and C buttons
    case negative, percent, decimal, equals, allClear, clear
    
    /// The button's text label.
    var description: String {
        switch self {
        case .digit(let digit): return digit.description
        case .operation(let operation): return operation.description
        case .negative: return "±"
        case .percent: return "%"
        case .decimal: return "."
        case .equals: return "="
        case .allClear: return "AC"
        case .clear: return "C"
        }
    }
    
    /// The button's background color.
    var backgroundColor: Color {
        switch self {
        case .allClear, .clear, .negative, .percent:
            return .topButtonBg
        case .operation, .equals:
            return .rightButtonBg
        case .digit, .decimal:
            return .numberButtonBg
        }
    }
    
    /// The button's text color.
    var foregroundColor: Color {
        switch self {
        case .allClear, .clear, .negative, .percent:
            return .topButtonText
        default:
            return .otherButtonText
        }
    }
}
