//
//  Calculator.swift
//  Calculator
//
//  Created by Max Valek on 8/1/23.
//

import Foundation

/// Calculator model/API
struct Calculator {
    
    // MARK: - PROPERTIES
    
    private var newNumber: Decimal?
    
    // MARK: - COMPUTED PROPERTIES
    
    var displayText: String {
        return getNumberString(forNumber: number, withCommas: true)
    }
    
    // Current displaying number
    private var number: Decimal? {
        newNumber
    }
    
    // MARK: - OPERATIONS
    
    mutating func setDigit(_ digit: Digit) {
        // 1. check if you can add the digit (01 shouldnt be possible)
        guard canAddDigit(digit) else { return }
        // 2. convert newNumber decimal to a string
        let numberString = getNumberString(forNumber: newNumber)
        // 3. append digit to end of string, convert string back to decimal, assign it to newNumber
        newNumber = Decimal(string: numberString.appending("\(digit.rawValue)"))
    }
    
    mutating func setOperation(_ operation: ArithmeticOperation) {
        
    }
    
    mutating func toggleSign() {
        
    }
    
    mutating func setPercent() {
        
    }
    
    mutating func setDecimal() {
        
    }
    
    mutating func evaluate() {
        
    }
    
    mutating func allClear() {
        
    }
    
    mutating func clear() {
        
    }
    
    // MARK: - HELPERS
    
    private func getNumberString(forNumber: Decimal?, withCommas: Bool = false) -> String {
        return (withCommas ? number?.formatted(.number) : number.map(String.init)) ?? "0"
    }
    
    private func canAddDigit(_ digit: Digit) -> Bool {
        return number != nil || digit != .zero
    }
}
