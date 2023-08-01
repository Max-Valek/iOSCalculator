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
                    size: getButtonSize(),
                    backgroundColor: buttonType.backgroundColor,
                    foregroundColor: buttonType.foregroundColor,
                    isWide: buttonType == .digit(.zero))
                )
        }
        
        // Calculate button size
        private func getButtonSize() -> CGFloat {
            let screenWidth = UIScreen.main.bounds.width
            let buttonCount: CGFloat = 4.0
            let spacingCount = buttonCount + 1
            return (screenWidth - (spacingCount * Constants.padding)) / buttonCount
        }
    }
}

struct CalculatorView_CalculatorButton_Previews: PreviewProvider {
    static var previews: some View {
        CalculatorView.CalculatorButton(buttonType: .digit(.five))
    }
}
