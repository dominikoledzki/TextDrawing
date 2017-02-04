//
//  DefaultLineBreaker.swift
//  TextDrawing
//
//  Created by Dominik Olędzki on 17/01/2017.
//  Copyright © 2017 Dominik Oledzki.
//

import CoreText
import UIKit

class DefaultLineBreaker: LineBreaker {
    
    private let attributedString: NSAttributedString
    private let typesetter: CTTypesetter
    private let unbrokenLine: CTLine
    
    required init(attributedString: NSAttributedString) {
        self.attributedString = attributedString
        self.typesetter = CTTypesetterCreateWithAttributedString(attributedString)
        self.unbrokenLine = CTTypesetterCreateLine(typesetter, CFRangeMake(0, 0))
    }
    
    func breakTextToLines(maxLineWidth width: CGFloat) -> [CTLine] {
        var result: [CTLine] = []
        
        let glyphsPositions = getGlyphsPositions()
        let glyphsIndices = getGlyphsIndices()
        let potentialLineBreaks = attributedString.string.getPotentialLineBreaks()

        var cumulatedWidth: CGFloat = 0.0
        var lastLineRange = CFRangeMake(0, 0)
        var lineBreakIndex = 0
        
        let lastLineBreakIndex = potentialLineBreaks.count - 1
        while lineBreakIndex != lastLineBreakIndex {
            
            while lineBreakIndex != lastLineBreakIndex &&
                glyphsPositions[potentialLineBreaks[lineBreakIndex]] - cumulatedWidth <= width {
                lineBreakIndex += 1
            }
            
            if lineBreakIndex != lastLineBreakIndex {
                lineBreakIndex -= 1
                let glyphPosition = glyphsPositions[potentialLineBreaks[lineBreakIndex]]
                cumulatedWidth = glyphPosition
            }
            
            let lineRangeLocation = lastLineRange.location + lastLineRange.length
            let breakLocation = potentialLineBreaks[lineBreakIndex]
            let lineRangeLength = breakLocation - lineRangeLocation
            let lineRange = CFRangeMake(lineRangeLocation, lineRangeLength)
            lastLineRange = lineRange
            
            let line = CTTypesetterCreateLine(typesetter, lineRange)
            result.append(line)
        }
        
        return result
    }
    
    private func getGlyphsPositions() -> [CGFloat] {
        var positions = [CGFloat]()
        for run in CTLineGetGlyphRuns(unbrokenLine) as! [CTRun] {
            let glyphsCount = CTRunGetGlyphCount(run)
            var runPositions = [CGPoint](repeating: CGPoint.nan, count: glyphsCount)
            CTRunGetPositions(run, CFRangeMake(0, 0), &runPositions)
            positions += runPositions.map { $0.x }
        }
        return positions
    }
    
    private func getGlyphsIndices() -> [CFIndex] {
        var indices = [CFIndex]()
        for run in CTLineGetGlyphRuns(unbrokenLine) as! [CTRun] {
            let glyphsCount = CTRunGetGlyphCount(run)
            var runIndices = [CFIndex](repeating: -1, count: glyphsCount)
            CTRunGetStringIndices(run, CFRangeMake(0, 0), &runIndices)
            indices += runIndices
        }
        return indices
    }
    
    private func getGlyphsCount() -> CFIndex {
        return CTLineGetGlyphCount(unbrokenLine)
    }
}
