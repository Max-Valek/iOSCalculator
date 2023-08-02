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
    
    /// Set up the calculator before each test case.
    override func setUpWithError() throws {
        try super.setUpWithError()
        calculator = Calculator()
    }
    
    /// Set calculator to nil after each test case.
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
        XCTAssertEqual(calculator.displayText, "-123", "Negating positive number failed.")
        
        /// From negative to positive
        calculator.appendDigit(.seven)      /// "-1237"
        calculator.appendDigit(.five)       /// "-12375"
        calculator.negate()                 /// "12375"
        XCTAssertEqual(calculator.displayText, "12,375", "Negating negative number failed.")
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
        
        XCTAssertEqual(calculator.displayText, "12,345.67", "First percentage conversion failed.")
        
        calculator.convertToPercentage()    /// "123.4567"
        
        XCTAssertEqual(calculator.displayText, "123.4567", "Second percentage conversion failed.")
        
        calculator.convertToPercentage()    /// "1.234567
        
        XCTAssertEqual(calculator.displayText, "1.234567", "Third percentage conversion failed.")
    }
    
    /// Test adding a decimal point.
    func test_add_decimal() {
        /// Test adding when not already in number
        calculator.appendDigit(.one)        /// "1"
        calculator.addDecimal()             /// "1."
        calculator.appendDigit(.two)        /// "1.2"
        calculator.appendDigit(.three)      /// "1.23"
        
        XCTAssertEqual(calculator.displayText, "1.23", "Failed to add decimal when not already in number.")
        
        calculator.addDecimal()             /// "1.23" don't add another decimal
        
        XCTAssertEqual(calculator.displayText, "1.23", "Added a second decimal.")
        
        calculator.addDecimal()             /// "1.23" don't add another decimal
        calculator.appendDigit(.zero)       /// "1.230"
        calculator.appendDigit(.zero)       /// "1.2300"
        
        XCTAssertEqual(calculator.displayText, "1.2300", "Numbers cannot be appended after failed addDecimal().")
    }
    
    /// Test resetting the calculator (all clear)
    func test_reset() {
        /// Test if displayText set back to 0 and showAllClear set to true after AC pressed.
        /// note: other (private) properties updated, dont have access.
        calculator.appendDigit(.one)        /// "1"
        calculator.appendDigit(.two)        /// "12"
        calculator.appendDigit(.three)      /// "123"
        
        calculator.reset()                  /// "0"
        
        XCTAssertEqual(calculator.displayText, "0", "Display text not set to zero after reset.")
        XCTAssertTrue(calculator.showAllClear, "showAllClear should be true after reset.")
    }
    
    /// Test clearing the last entry (clear). Same as above with our current access.
    func test_clear_last_entry() {
        /// Test if displayText set back to 0 and showAllClear set to true after AC pressed.
        /// note: other (private) properties updated, dont have access.
        calculator.appendDigit(.one)        /// "1"
        calculator.appendDigit(.two)        /// "12"
        calculator.appendDigit(.three)      /// "123"
        
        calculator.clearLastEntry()         /// "0"
        
        XCTAssertEqual(calculator.displayText, "0", "Display text not set to zero after clearing last entry.")
        XCTAssertTrue(calculator.showAllClear, "showAllClear should be true after clearing last entry.")
    }
    
    /// Test the canAddDigit function
    func test_can_add_digit() {
        /// Make sure 0s cant be appended to nil currentNumber.
        calculator.appendDigit(.zero)
        calculator.appendDigit(.zero)
        calculator.appendDigit(.zero)
        
        XCTAssertEqual(calculator.displayText, "0", "Should not be able to add 0s when currentNumber nil.")
        
        /// Make sure adding above zeros doesn't break appendDigit function.
        
        calculator.appendDigit(.one)
        
        XCTAssertEqual(calculator.displayText, "1", "Adding zeros at beginning breaks appendDigit.")
        
        /// Make sure adding a decimal works as expected.

        calculator.addDecimal()
        calculator.appendDigit(.zero)
        calculator.appendDigit(.five)
        
        XCTAssertEqual(calculator.displayText, "1.05", "Adding decimal failed.")
    }

    // MARK: - Operations
    
    /// Test addition operation
    func test_addition() {
        /// Test simplest addition (1 + 2)
        calculator.appendDigit(.one)            /// "1"
        calculator.setOperation(.addition)      /// "0", operation("1", "+")
        calculator.appendDigit(.two)            /// "2", operation("1", "+")
        calculator.calculateResult()            /// "3", 1 + 2 = 3
        XCTAssertEqual(calculator.displayText, "3", "Simple addition (1 + 2) failed.")
        
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
        XCTAssertEqual(calculator.displayText, "15", "Adding decimals (10.05 + 4.95) failed.")
        
        /// Test consecutive additions (add 5 to the result set above)
        calculator.setOperation(.addition)      /// "0", operation("15", "+")
        calculator.appendDigit(.five)           /// "5", operation("15", "+")
        calculator.calculateResult()            /// "20", 15 + 5 = 20
        XCTAssertEqual(calculator.displayText, "20", "Consecutive additions (adding to result) failed.")
    }
    
    /// Test subtraction operation
    func test_subtraction() {
        /// Test simplest subtraction (2 - 1)
        calculator.appendDigit(.two)                /// "2"
        calculator.setOperation(.subtraction)       /// "0", operation("2", "-")
        calculator.appendDigit(.one)                /// "1", operation("2", "-")
        calculator.calculateResult()                /// "1", 2 - 1 = 1
        XCTAssertEqual(calculator.displayText, "1", "Simple subtraction (2 - 1) failed.")
        
        /// Test subtracting decimals (10.05 - 5.05)
        calculator.reset()                          /// "0"
        calculator.appendDigit(.one)                /// "1"
        calculator.appendDigit(.zero)               /// "10"
        calculator.addDecimal()                     /// "10."
        calculator.appendDigit(.zero)               /// "10.0"
        calculator.appendDigit(.five)               /// "10.05"
        calculator.setOperation(.subtraction)       /// "0", operation("10.05", "-")
        calculator.appendDigit(.five)               /// "5", operation("10.05", "-")
        calculator.addDecimal()                     /// "5.", operation("10.05", "-")
        calculator.appendDigit(.zero)               /// "5.0", operation("10.05", "-")
        calculator.appendDigit(.five)               /// "5.05", operation("10.05", "-")
        calculator.calculateResult()                /// "5", 10.05 - 5.05 = 5
        XCTAssertEqual(calculator.displayText, "5", "Subtracting decimals (10.05 - 5.05) failed.")
        
        /// Test consecutive subtractions (subtract 3 from the result set above)
        calculator.setOperation(.subtraction)       /// "0", operation("5", "-")
        calculator.appendDigit(.three)              /// "3", operation("5", "-")
        calculator.calculateResult()                /// "2", 5 - 3 = 2
        XCTAssertEqual(calculator.displayText, "2", "Consecutive subtractions (subtracting from result) failed.")
    }
    
    /// Test multiplication operation
    func test_multiplication() {
        /// Test simplest multiplication (2 * 1)
        calculator.appendDigit(.two)                    /// "2"
        calculator.setOperation(.multiplication)        /// "0", operation("2", "x")
        calculator.appendDigit(.one)                    /// "1", operation("2", "x")
        calculator.calculateResult()                    /// "2", 2 * 1 = 2
        XCTAssertEqual(calculator.displayText, "2", "Simple multiplication (2 * 1) failed.")
        
        /// Test multiplying decimals (2.5 * 4.5)
        calculator.reset()                              /// "0"
        calculator.appendDigit(.two)                    /// "2"
        calculator.addDecimal()                         /// "2."
        calculator.appendDigit(.five)                   /// "2.5"
        calculator.setOperation(.multiplication)        /// "0", operation("2.5", "x")
        calculator.appendDigit(.four)                   /// "4", operation("2.5", "x")
        calculator.addDecimal()                         /// "4.", operation("2.5", "x")
        calculator.appendDigit(.five)                   /// "4.5", operation("2.5", "x")
        calculator.calculateResult()                    /// "11.25", 2.5 x 4.5 = 11.25
        XCTAssertEqual(calculator.displayText, "11.25", "Multiplying decimals (2.5 * 4.5) failed.")
        
        /// Test consecutive multiplications (multiply the result set above by 3)
        calculator.setOperation(.multiplication)        /// "0", operation("11.25", "x")
        calculator.appendDigit(.three)                  /// "3", operation("11.25", "x")
        calculator.calculateResult()                    /// "33.75", 11.25 x 3 = 33.75
        XCTAssertEqual(calculator.displayText, "33.75", "Consecutive multiplies (multiplying to result) failed.")
    }
    
    /// Test division operation
    func test_division() {
        /// Test simplest division (4 / 2)
        calculator.appendDigit(.four)           /// "4"
        calculator.setOperation(.division)      /// "0", operation("4", "/")
        calculator.appendDigit(.two)            /// "2", operation("4", "/")
        calculator.calculateResult()            /// "2", 4 / 2 = 2
        XCTAssertEqual(calculator.displayText, "2", "Simple division (4 / 2) failed.")
        
        /// Test dividing decimals (20.7 / 4.5)
        calculator.reset()                              /// "0"
        calculator.appendDigit(.two)                    /// "2"
        calculator.appendDigit(.zero)                   /// "20"
        calculator.addDecimal()                         /// "20."
        calculator.appendDigit(.seven)                  /// "20.7"
        calculator.setOperation(.division)              /// "0", operation("20.7", "/")
        calculator.appendDigit(.four)                   /// "4", operation("20.7", "/")
        calculator.addDecimal()                         /// "4.", operation("20.7", "/")
        calculator.appendDigit(.five)                   /// "4.5", operation("20.7", "/")
        calculator.calculateResult()                    /// "4.6", 20.7 / 4.5 = 4.6
        XCTAssertEqual(calculator.displayText, "4.6", "Dividing decimals (20.7 / 4.5) failed.")
        
        /// Test consecutive divisions (divide the result set above by 2.3)
        calculator.setOperation(.division)      /// "0", operation("4.6", "/")
        calculator.appendDigit(.two)            /// "2", operation("4.6", "/")
        calculator.addDecimal()                 /// "2.", operation("4.6", "/")
        calculator.appendDigit(.three)          /// "2.3", operation("4.6", "/")
        calculator.calculateResult()            /// "2", 4.6 / 2.3 = 2
        XCTAssertEqual(calculator.displayText, "2", "Consecutive divides (dividing from result) failed.")
    }

}
