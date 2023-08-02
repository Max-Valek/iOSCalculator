//
//  CalculatorButtonStyle.swift
//  Calculator
//
//  Created by Max Valek on 8/1/23.
//

import SwiftUI

/// Custom ButtonStyle for calculator buttons
struct CalculatorButtonStyle: ButtonStyle {
    
    // MARK: - PROPERTIES
    
    var size: CGFloat
    var backgroundColor: Color
    var foregroundColor: Color
    var isWide: Bool = false        // wide button (0)
    
    // MARK: - BODY
    
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .font(.system(size: Constants.buttonLabelSize, weight: .medium))
            .frame(width: size, height: size)
            .frame(maxWidth: isWide ? .infinity : size, alignment: .leading)
            .background(backgroundColor)
            .foregroundColor(foregroundColor)
            .overlay {
                /// overlay button with buttonPressedOverlay color when currently being pressed.
                if configuration.isPressed {
                    Color.buttonPressedOverlay
                }
            }
            .clipShape(Capsule())
    }
}
