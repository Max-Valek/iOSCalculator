//
//  ArithmeticExpressionTests.swift
//  CalculatorTests
//
//  Created by Max Valek on 8/3/23.
//

import XCTest
@testable import Calculator

class ArithmeticExpressionTests: XCTestCase {
    
    /// Sample test to ensure mock is working.
    func testEvaluate() {
        // Create an instance of the ArithmeticExpressionMock
        let mock = ArithmeticExpressionMock(number: 5.0, operation: .addition)
        
        // Call the evaluate method on the mock with a second number
        let result = mock.evaluate(with: 3.0)
        
        // Verify that the evaluate method was called
        XCTAssertTrue(mock.evaluateCalled)
        
        // Verify that the result is as expected
        XCTAssertEqual(result, -111.0)
    }
}
