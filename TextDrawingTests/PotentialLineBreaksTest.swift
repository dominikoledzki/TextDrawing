//
//  PotentialLineBreaksTest.swift
//  TextDrawing
//
//  Created by Dominik Olędzki on 18/01/2017.
//  Copyright © 2017 Dominik Oledzki. All rights reserved.
//

import XCTest
@testable import TextDrawing

class PotentialLineBreaksTest: XCTestCase {
    
    func testEmptyStringShouldNotBreak() {
        XCTAssertEqual("".getPotentialLineBreaks(), [])
    }
    
    func testOneSimpleLineBreak() {
        let str = "Hello, World!"
        let lineBreaks = str.getPotentialLineBreaks()
        XCTAssertEqual(lineBreaks, [7])
    }
    
    func testLongerButSimpleLineBreaks() {
        let str = "Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod"
        let lineBreaks = str.getPotentialLineBreaks()
        XCTAssertEqual(lineBreaks, [6, 12, 18, 22, 28, 40, 52, 58, 62, 65])
    }
    
    func testTwoConsecutiveSpacesShouldCreateOneBreakPossibility() {
        let str = "Hello,  World!"
        let lineBreaks = str.getPotentialLineBreaks()
        XCTAssertEqual(lineBreaks, [8])
    }
    
    func testThreeConsecutiveSpacesShouldCreateOneBreakPossibility() {
        let str = "Hello,   World!"
        let lineBreaks = str.getPotentialLineBreaks()
        XCTAssertEqual(lineBreaks, [9])
    }
    
    func testSpaceAtTheEndShouldNotCreateBreakPossibility() {
        let str = "Hello, World! "
        let lineBreaks = str.getPotentialLineBreaks()
        XCTAssertEqual(lineBreaks, [7])
    }
}
