//
//  CalculatorButtonStyle.swift
//  Calculator
//
//  Created by Max Valek on 8/1/23.
//

import SwiftUI

/// Custom ButtonStyle for calculator buttons
struct CalculatorButtonStyle: ButtonStyle {
    
    var size: CGFloat               // button size
    var backgroundColor: Color      // button background
    var foregroundColor: Color      // button text
    var isWide: Bool = false        // wide button (0)
    
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .font(.system(size: 32, weight: .medium))
            .frame(width: size, height: size)
            .frame(maxWidth: isWide ? .infinity : size, alignment: .leading)
            .background(backgroundColor)
            .foregroundColor(foregroundColor)
            .overlay {
                if configuration.isPressed {
                    Color(white: 1.0, opacity: 0.2)
                }
            }
            .clipShape(Capsule())
    }
}
