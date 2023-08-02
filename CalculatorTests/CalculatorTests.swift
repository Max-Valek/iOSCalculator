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
        /// Make sure simple append works
        calculator.appendDigit(.one)        /// "1"
        calculator.appendDigit(.two)        /// "12"
        calculator.appendDigit(.three)      /// "123"
        XCTAssertEqual(calculator.displayText, "123", "Simple append incorrect.")
        
        /// Make sure decimals are handle correctly
        calculator.appendDigit(.zero)       /// "1230"
        calculator.addDecimal()             /// "1230."
        calculator.appendDigit(.nine)       /// "1230.9"
        XCTAssertEqual(calculator.displayText, "1,230.9", "Appending with decimals not handled correctly.")
    }
    
    /// Test negating the number (toggling between positive and negative).
    func test_negate() {
        /// From positive to negative
        calculator.appendDigit(.one)        /// "1"
        calculator.appendDigit(.two)        /// "12"
        calculator.appendDigit(.three)      /// "123"
        calculator.negate()                 /// "-123"
        XCTAssertEqual(calculator.displayText, "-123")
        
        /// From negative to positive
        calculator.appendDigit(.seven)      /// "-1237"
        calculator.appendDigit(.five)       /// "-12375"
        calculator.negate()                 /// "12375"
        XCTAssertEqual(calculator.displayText, "12,375")
    }
    
    /// Test converting the number to a percentage
    func test_convert_to_percentage() {
        /// Convert a number to a percentage of 100 multiple times.
        calculator.appendDigit(.one)        /// "1"
        calculator.appendDigit(.two)        /// "12"
        calculator.appendDigit(.three)      /// "123"
        calculator.appendDigit(.four)       /// "1234"
        calculator.appendDigit(.five)       /// "12345"
        calculator.appendDigit(.six)        /// "123456"
        calculator.appendDigit(.seven)      /// "1234567"
        
        calculator.convertToPercentage()    /// "12345.67"
        
        XCTAssertEqual(calculator.displayText, "12,345.67")
        
        calculator.convertToPercentage()    /// "123.4567"
        
        XCTAssertEqual(calculator.displayText, "123.4567")
        
        calculator.convertToPercentage()    /// "1.234567
        
        XCTAssertEqual(calculator.displayText, "1.234567")
    }
    
    /// Test adding a decimal point.
    func test_add_decimal() {
        /// Test adding when not already in number
        calculator.appendDigit(.one)        /// "1"
        calculator.addDecimal()             /// "1."
        calculator.appendDigit(.two)        /// "1.2"
        calculator.appendDigit(.three)      /// "1.23"
        
        XCTAssertEqual(calculator.displayText, "1.23")
        
        calculator.addDecimal()             /// "1.23" don't add another decimal
        
        XCTAssertEqual(calculator.displayText, "1.23")
        
        calculator.addDecimal()             /// "1.23" don't add another decimal
        calculator.appendDigit(.zero)       /// "1.230"
        calculator.appendDigit(.zero)       /// "1.2300"
        
        XCTAssertEqual(calculator.displayText, "1.2300")
    }
    
    /// Test resetting the calculator (all clear)
    func test_reset() {
        /// Test if displayText set back to 0 and showAllClear set to true after AC pressed.
        /// note: other (private) properties updated, dont have access.
        calculator.appendDigit(.one)        /// "1"
        calculator.appendDigit(.two)        /// "12"
        calculator.appendDigit(.three)      /// "123"
        
        calculator.reset()                  /// "0"
        
        XCTAssertEqual(calculator.displayText, "0")
        XCTAssertTrue(calculator.showAllClear)
    }
    
    /// Test clearing the last entry (clear). Same as above with our current access.
    func test_clear_last_entry() {
        /// Test if displayText set back to 0 and showAllClear set to true after AC pressed.
        /// note: other (private) properties updated, dont have access.
        calculator.appendDigit(.one)        /// "1"
        calculator.appendDigit(.two)        /// "12"
        calculator.appendDigit(.three)      /// "123"
        
        calculator.reset()                  /// "0"
        
        XCTAssertEqual(calculator.displayText, "0")
        XCTAssertTrue(calculator.showAllClear)
    }
    
    /// Test the canAddDigit function
    func test_can_add_digit() {
        /// Make sure 0s cant be appended to nil currentNumber.
        calculator.appendDigit(.zero)
        calculator.appendDigit(.zero)
        calculator.appendDigit(.zero)
        
        XCTAssertEqual(calculator.displayText, "0")
        
        /// Make sure adding above zeros doesn't break appendDigit function.
        
        calculator.appendDigit(.one)
        
        XCTAssertEqual(calculator.displayText, "1")
        
        /// Make sure adding a decimal works as expected.

        calculator.addDecimal()
        calculator.appendDigit(.zero)
        calculator.appendDigit(.five)
        
        XCTAssertEqual(calculator.displayText, "1.05")
    }

    // MARK: - Operations
    
    /// Test addition operation
    func test_addition() {
        /// Test simplest addition (1 + 2)
        calculator.appendDigit(.one)            /// "1"
        calculator.setOperation(.addition)      /// "0", operation("1", "+")
        calculator.appendDigit(.two)            /// "2", operation("1", "+")
        calculator.calculateResult()            /// "3", 1 + 2 = 3
        XCTAssertEqual(calculator.displayText, "3")
        
        /// Test adding decimals (10.05 + 4.95)
        calculator.reset()                      /// "0"
        calculator.appendDigit(.one)            /// "1"
        calculator.appendDigit(.zero)           /// "10"
        calculator.addDecimal()                 /// "10."
        calculator.appendDigit(.zero)           /// "10.0"
        calculator.appendDigit(.five)           /// "10.05"
        calculator.setOperation(.addition)      /// "0", operation("10.05", "+")
        calculator.appendDigit(.four)           /// "4", operation("10.05", "+")
        calculator.addDecimal()                 /// "4.", operation("10.05", "+")
        calculator.appendDigit(.nine)           /// "4.9", operation("10.05", "+")
        calculator.appendDigit(.five)           /// "4.95", operation("10.05", "+")
        calculator.calculateResult()            /// "15", 10.05 + 4.95 = 15
        XCTAssertEqual(calculator.displayText, "15")
        
        /// Test consecutive additions (add 5 to the result set above)
        calculator.setOperation(.addition)      /// "0", operation("15", "+")
        calculator.appendDigit(.five)           /// "5", operation("15", "+")
        calculator.calculateResult()            /// "20", 15 + 5 = 20
        XCTAssertEqual(calculator.displayText, "20")
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
