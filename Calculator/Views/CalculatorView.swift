//
//  CalculatorView.swift
//  Calculator
//
//  Created by Max Valek on 8/1/23.
//

import SwiftUI

/// Main view for the app.
struct CalculatorView: View {
    
    // MARK: - PROPERTIES
    
    /// View model instance passed in from environment
    @EnvironmentObject private var viewModel: ViewModel
    
    // MARK: - BODY
    
    var body: some View {
        VStack {
            Spacer()
            /// The number currently displayed above buttons
            displayText
            /// Calculator buttons
            buttonPad
        }
        .padding(Constants.padding)
        .background(Color.background)
    }
}

// MARK: - PREVIEWS

struct CalculatorView_Previews: PreviewProvider {
    static var previews: some View {
        CalculatorView()
            .environmentObject(CalculatorView.ViewModel())
    }
}

// MARK: - COMPONENTS

extension CalculatorView {
    /// Number being displayed
    private var displayText: some View {
        Text(viewModel.displayText)
            .padding()
            .foregroundColor(Color.displayTextColor)
            .frame(maxWidth: .infinity, alignment: .trailing)
            .font(.system(size: Constants.displayTextSize, weight: .light))
            .lineLimit(Constants.maxLines)              // max lines for display text
            .minimumScaleFactor(Constants.minScale)     // shrink when displaying large numbers
    }
    
    /// Calculator buttons
    private var buttonPad: some View {
        VStack(spacing: Constants.padding) {
            ForEach(viewModel.buttons, id: \.self) { row in
                HStack(spacing: Constants.padding) {
                    ForEach(row, id: \.self) { buttonType in
                        CalculatorButton(buttonType: buttonType)
                    }
                }
            }
        }
    }
}
