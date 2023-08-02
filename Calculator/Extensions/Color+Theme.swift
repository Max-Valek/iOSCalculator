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
    static let topButtonBg = Color(.lightGray)
    static let rightButtonBg = Color.orange
    static let numberButtonBg = Color.secondary
    
    /// foregrounds
    static let topButtonText = Color.black
    static let otherButtonText = Color.white
    
    /// Button overlay when pressed
    static let buttonPressedOverlay = Color(white: 1.0, opacity: 0.2)
    
    // MARK: DISPLAY TEXT
    
    /// Display text color
    static let displayTextColor = Color.white
}

