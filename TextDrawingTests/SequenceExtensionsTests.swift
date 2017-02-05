//
//  SequenceExtensionsTests.swift
//  TextDrawing
//
//  Created by Dominik Olędzki on 04/02/2017.
//  Copyright © 2017 Dominik Oledzki. All rights reserved.
//

import XCTest

class SequenceExtensionsTests: XCTestCase {
    
    func testLastElementWhichSquareIsLessThan50() {
        let x = 0..<20
        let lastIntegerWhichSquareIsLessThan50 = x.last { (element) -> Bool in
            return element * element < 50
        }
        XCTAssertEqual(lastIntegerWhichSquareIsLessThan50, 7)
    }
    
    func testNoElementPasses() {
        let x = 100..<200
        let lastPassing = x.last { (element) -> Bool in
            return element > 300
        }
        XCTAssertNil(lastPassing)
    }
    
    func testAllElementsPassing() {
        let x = (10..<20).map { $0 * 2 }
        let lastEven = x.last { (element) -> Bool in
            return element % 2 == 0
        }
        XCTAssertEqual(lastEven, x.last)
    }
}
