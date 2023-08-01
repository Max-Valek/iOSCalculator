//
//  CalculatorView.swift
//  Calculator
//
//  Created by Max Valek on 8/1/23.
//

import SwiftUI

struct CalculatorView: View {
    
    var body: some View {
        
        VStack {
            Spacer()
            Text("0")
                .padding()
                .foregroundColor(.white)
                .frame(maxWidth: .infinity, alignment: .trailing)
                .font(.system(size: 88, weight: .light))
                .lineLimit(1)               // only 1 line
                .minimumScaleFactor(0.2)    // shrink when displaying large numbers
        }
        .background(Color.black)
    }
}

struct CalculatorView_Previews: PreviewProvider {
    static var previews: some View {
        CalculatorView()
    }
}
