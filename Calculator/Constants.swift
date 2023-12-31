//
//  Constants.swift
//  Calculator
//
//  Created by Max Valek on 8/1/23.
//

import Foundation
import CoreGraphics /// (CGFloat)

/// Constant used throughout the app.
struct Constants {
    
    // MARK: APP
    
    static let padding: CGFloat = 12.0              /// use constant padding throughout
    
    // MARK: BUTTONS
    
    static let buttonLabelSize: CGFloat = 32.0      /// font size for button text
    static let buttonsPerRow: CGFloat = 4.0         /// number of buttons in each row (4)
    
    // MARK: DISPLAY TEXT
    
    static let displayTextSize: CGFloat = 88.0      /// font size of current input number displayed above buttons
    static let maxLines: Int = 1                    /// line limit for display text
    static let minScale: CGFloat = 0.2              /// minimum scale factor for display text
}
