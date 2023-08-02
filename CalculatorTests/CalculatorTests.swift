//
//  CalculatorTests.swift
//  CalculatorTests
//
//  Created by Max Valek on 8/2/23.
//

import XCTest
@testable import Calculator

final class CalculatorTests: XCTestCase {
    
    /// Calculator property
    var calculator: Calculator!
    
    // MARK: - SETUP AND TEARDOWN
    
    /// Setup function called before each test
    override func setUpWithError() throws {
        try super.setUpWithError()
        calculator = Calculator()
    }
    
    /// Tear down function called after each test
    override func tearDownWithError() throws {
        calculator = nil
        try super.tearDownWithError()
    }
    
    // MARK: - Updating values when buttons pressed
    
    /// Test appending digits to the number when digit button pressed.
    func test_appending_digits() {
        calculator.appendDigit(.one)
        calculator.appendDigit(.two)
        calculator.appendDigit(.three)
        
        XCTAssertEqual(calculator.displayText, "123")
        
        calculator.appendDigit(.zero)
        calculator.addDecimal()
        calculator.appendDigit(.nine)
        
        XCTAssertEqual(calculator.displayText, "1,230.9")
    }
    
    /// Test negating the number
    func test_negate() {
        calculator.appendDigit(.one)
        calculator.appendDigit(.two)
        calculator.appendDigit(.three)
        calculator.negate()
        
        XCTAssertEqual(calculator.displayText, "-123")
        
        calculator.appendDigit(.seven)
        calculator.appendDigit(.five)
        calculator.negate()
        
        XCTAssertEqual(calculator.displayText, "12,375")
    }
    
    /// Test converting the number to a percentage
    func test_convert_to_percentage() {
        calculator.appendDigit(.one)
        calculator.appendDigit(.two)
        calculator.appendDigit(.three)
        calculator.appendDigit(.four)
        calculator.appendDigit(.five)
        calculator.appendDigit(.six)
        calculator.appendDigit(.seven)
        
        calculator.convertToPercentage()
        
        XCTAssertEqual(calculator.displayText, "12,345.67")
        
        calculator.convertToPercentage()
        
        XCTAssertEqual(calculator.displayText, "123.4567")
        
        calculator.convertToPercentage()
        
        XCTAssertEqual(calculator.displayText, "1.234567")
    }
    
    /// Test adding a decimal point
    func test_add_decimal() {
        calculator.appendDigit(.one)
        calculator.addDecimal()
        calculator.appendDigit(.two)
        calculator.appendDigit(.three)
        
        XCTAssertEqual(calculator.displayText, "1.23")
    }
    
    /// Test resetting the calculator (all clear)
    func test_reset() {
        calculator.appendDigit(.one)
        calculator.appendDigit(.two)
        calculator.appendDigit(.three)
        
        calculator.reset()
        
        XCTAssertEqual(calculator.displayText, "0")
    }
    
    /// Test clearing the last entry (clear)
    func test_clear_last_entry() {
        calculator.appendDigit(.one)
        calculator.appendDigit(.two)
        calculator.appendDigit(.three)
        
        calculator.clearLastEntry()
        
        XCTAssertEqual(calculator.displayText, "0")
    }
    
    /// Test the canAddDigit function
    func test_can_add_digit() {
        calculator.appendDigit(.zero)
        calculator.appendDigit(.zero)
        calculator.appendDigit(.zero)
        
        XCTAssertEqual(calculator.displayText, "0")
    }

    // MARK: - Operations
    
    /// Test addition operation
    func test_addition() {
        calculator.appendDigit(.one)
        calculator.setOperation(.addition)
        calculator.appendDigit(.two)
        calculator.calculateResult()
        
        XCTAssertEqual(calculator.displayText, "3")
    }
    
    /// Test subtraction operation
    func test_subtraction() {
        calculator.appendDigit(.five)
        calculator.setOperation(.subtraction)
        calculator.appendDigit(.two)
        calculator.calculateResult()
        
        XCTAssertEqual(calculator.displayText, "3")
    }
    
    /// Test multiplication operation
    func test_multiplication() {
        calculator.appendDigit(.five)
        calculator.setOperation(.multiplication)
        calculator.appendDigit(.two)
        calculator.calculateResult()
        
        XCTAssertEqual(calculator.displayText, "10")
    }
    
    /// Test division operation
    func test_division() {
        calculator.appendDigit(.six)
        calculator.setOperation(.division)
        calculator.appendDigit(.two)
        calculator.calculateResult()
        
        XCTAssertEqual(calculator.displayText, "3")
    }

}
