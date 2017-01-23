//
//  DefaultLineBreakerTests.swift
//  TextDrawing
//
//  Created by Dominik Olędzki on 23/01/2017.
//  Copyright © 2017 Dominik Oledzki. All rights reserved.
//

import XCTest
@testable import TextDrawing

class DefaultLineBreakerTests: XCTestCase {
    
    func testLoremIpsumExample() {
        let font = UIFont.systemFont(ofSize: 12.0)
        let maxLineWidth = 280.0
        
        let attributedString = NSAttributedString(string: "Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.", attributes: [
            NSFontAttributeName: font
            ])
        
        let lines = DefaultLineBreaker().breakTextToLines(attributedString: attributedString, maxLineWidth: maxLineWidth)
        
        let lineBreakPoints = [40, 80, 128, 176, 222, 272, 320, 370, 420]
        let expectedLines = linesFromLineBreakPoints(attributedString: attributedString, lineBreakPoints: lineBreakPoints)
        
        XCTAssertEqual(lines.count, expectedLines.count, "Calculated lines count: \(lines.count), expected lines count: \(expectedLines.count)")
        
        for (line, expectedLine) in zip(lines, expectedLines) {
            let lineRange = CTLineGetStringRange(line)
            let expectedRange = CTLineGetStringRange(expectedLine)
            let test = lineRange == expectedRange
            
            XCTAssert(test, "Calculated line range: \(lineRange), Expected line range: \(expectedRange)")
        }
    }
    
    func linesFromLineBreakPoints(attributedString: NSAttributedString, lineBreakPoints: [Int]) -> [CTLine] {
        var results = [CTLine]()
        let length = attributedString.length
        let lineBreakPoints = lineBreakPoints + [length]
        
        var start = 0
        for point in lineBreakPoints {
            let range = NSRange(start..<point)
            start = point
            
            let substring = attributedString.attributedSubstring(from: range)
            let line = CTLineCreateWithAttributedString(substring)
            results.append(line)
        }
        
        return results
    }
}

func == (lhs: CFRange, rhs: CFRange) -> Bool {
    return lhs.location == rhs.location && lhs.length == rhs.length
}

func == (lhs: CTLine, rhs: CTLine) -> Bool {
    fatalError("Not implemented")
}
