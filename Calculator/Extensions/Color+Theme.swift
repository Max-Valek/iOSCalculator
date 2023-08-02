//
//  Color+Theme.swift
//  Calculator
//
//  Created by Max Valek on 8/2/23.
//

import SwiftUI

/// Color extension for app theme.
extension Color {
    
    // MARK: App
    
    static let background = Color.black
    
    // MARK: BUTTONS
    
    /// backgrounds
    static let topButtonBg = Color(.lightGray)      /// C/AC, ±, and %
    static let rightButtonBg = Color.orange         /// right column (÷, x, -, +, =)
    static let numberButtonBg = Color.secondary     /// digits and decimal
    
    /// foregrounds
    static let topButtonText = Color.black          /// C/AC, ±, and %
    static let otherButtonText = Color.white        /// every other button
    
    /// Button overlay when pressed
    static let buttonPressedOverlay = Color(white: 1.0, opacity: 0.2)
    
    // MARK: DISPLAY TEXT
    
    static let displayTextColor = Color.white       /// Display text color
}

