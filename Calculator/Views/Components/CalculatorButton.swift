//
//  CalculatorButton.swift
//  Calculator
//
//  Created by Max Valek on 8/1/23.
//

import SwiftUI

// CalculatorButton will not be used outside CalculatorView, so put it in an extension.
extension CalculatorView {
    
    struct CalculatorButton: View {
        
        let buttonType: ButtonType
        
        var body: some View {
            Button(buttonType.description, action: {})
                .buttonStyle(CalculatorButtonStyle(
                    size: 80,
                    backgroundColor: buttonType.backgroundColor,
                    foregroundColor: buttonType.foregroundColor)
                )
        }
    }
}

struct CalculatorView_CalculatorButton_Previews: PreviewProvider {
    static var previews: some View {
        CalculatorView.CalculatorButton(buttonType: .digit(.five))
    }
}
