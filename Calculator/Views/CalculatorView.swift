//
//  CalculatorView.swift
//  Calculator
//
//  Created by Max Valek on 8/1/23.
//

import SwiftUI

// MARK: - BODY

struct CalculatorView: View {
    
    /// View model instance passed in from environment
    @EnvironmentObject private var viewModel: ViewModel
    
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
            .environmentObject(CalculatorView.ViewModel())
    }
}

// MARK: - COMPONENTS

extension CalculatorView {
    /// Number being displayed
    private var displayText: some View {
        Text(viewModel.displayText)
            .padding()
            .foregroundColor(.white)
            .frame(maxWidth: .infinity, alignment: .trailing)
            .font(.system(size: 88, weight: .light))
            .lineLimit(1)               // only 1 line
            .minimumScaleFactor(0.2)    // shrink when displaying large numbers
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
