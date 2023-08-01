//
//  CalculatorView.swift
//  Calculator
//
//  Created by Max Valek on 8/1/23.
//

import SwiftUI

// MARK: - BODY

struct CalculatorView: View {
    
    // Calculator buttons with the correct order
    var buttonTypes: [[ButtonType]] {
        [[.allClear, .negative, .percent, .operation(.division)],
            [.digit(.seven), .digit(.eight), .digit(.nine), .operation(.multiplication)],
            [.digit(.four), .digit(.five), .digit(.six), .operation(.subtraction)],
            [.digit(.one), .digit(.two), .digit(.three), .operation(.addition)],
            [.digit(.zero), .decimal, .equals]]
    }
    
    var body: some View {
        VStack {
            Spacer()
            displayText
            buttonPad
        }
        .padding(Constants.padding)
        .background(Color.black)
    }
}

// MARK: - PREVIEWS

struct CalculatorView_Previews: PreviewProvider {
    static var previews: some View {
        CalculatorView()
    }
}

// MARK: - COMPONENTS

// Encapsulate subviews
extension CalculatorView {
    
    private var displayText: some View {
        Text("0")
            .padding()
            .foregroundColor(.white)
            .frame(maxWidth: .infinity, alignment: .trailing)
            .font(.system(size: 88, weight: .light))
            .lineLimit(1)               // only 1 line
            .minimumScaleFactor(0.2)    // shrink when displaying large numbers
    }
    
    private var buttonPad: some View {
        VStack(spacing: Constants.padding) {
            ForEach(buttonTypes, id: \.self) { row in
                HStack(spacing: Constants.padding) {
                    ForEach(row, id: \.self) { buttonType in
                        CalculatorButton(buttonType: buttonType)
                    }
                }
            }
        }
    }
}
