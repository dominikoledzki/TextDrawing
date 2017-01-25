//
//  DefaultLineBreakerTests.swift
//  TextDrawing
//
//  Created by Dominik Olędzki on 23/01/2017.
//  Copyright © 2017 Dominik Oledzki.
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
        
        let lineBreakPoints = [40, 80, 128, 176, 222, 272, 320, 370, 419]
        let expectedLines = linesFromLineBreakPoints(attributedString: attributedString, lineBreakPoints: lineBreakPoints)
        
        XCTAssertEqual(lines.count, expectedLines.count, "Calculated lines count: \(lines.count), expected lines count: \(expectedLines.count)")
        
        for (i, (line, expectedLine)) in zip(lines, expectedLines).enumerated() {
            XCTAssert(line == expectedLine, "Line number \(i) invalid")
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
    guard let lhsRuns = CTLineGetGlyphRuns(lhs) as? [CTRun] else { return false }
    guard let rhsRuns = CTLineGetGlyphRuns(rhs) as? [CTRun] else { return false }
    
    return lhsRuns == rhsRuns
}

extension CTRun: Equatable {
    public static func == (lhs: CTRun, rhs: CTRun) -> Bool {
        let lhsGlyphCount = CTRunGetGlyphCount(lhs)
        let rhsGlyphCount = CTRunGetGlyphCount(rhs)
        
        if lhsGlyphCount != rhsGlyphCount {
            return false
        }
        
        var lhsGlyphBuffer = [CGGlyph](repeating: 0, count: lhsGlyphCount)
        var rhsGlyphBuffer = [CGGlyph](repeating: 0, count: lhsGlyphCount)
        
        let allGlyphsRange = CFRangeMake(0, 0)
        
        CTRunGetGlyphs(lhs, allGlyphsRange, &lhsGlyphBuffer)
        CTRunGetGlyphs(rhs, allGlyphsRange, &rhsGlyphBuffer)
        
        return lhsGlyphBuffer == rhsGlyphBuffer
    }
}
