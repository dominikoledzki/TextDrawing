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
    func breakTextToLines(attributedString: NSAttributedString, maxLineWidth width: Double) -> [CTLine] {
        let charactersPositions = getCharactersPositions(attributedString: attributedString)
        
        // 2. While there are still characters to go, form a line.
        // 3. Return array of lines
        // 4. Clean up
        
        
        // get potential line breaks
        let potentialLineBreaks = attributedString.string.getPotentialLineBreaks()
        
        
        
        print(potentialLineBreaks)
        fatalError()
        
        /*
        let typesetter = CTTypesetterCreateWithAttributedString(attributedString)
        var lines = [CTLine]()
        var start: CFIndex = 0
        let length: CFIndex = CFAttributedStringGetLength(attributedString)
        
        while length - start > 0 {
            let count = CTTypesetterSuggestLineBreak(typesetter, start, width)
            let line = CTTypesetterCreateLine(typesetter, CFRangeMake(start, count))
            start += count
            lines.append(line)
        }
        return lines
 */
//        return []
    }
    
    private func getCharactersPositions(attributedString: NSAttributedString) -> [CGFloat] {
        var positions = [CGFloat]()
        let line = getOneLine(attributedString: attributedString)
        print(CTLineGetGlyphRuns(line))
        for run in CTLineGetGlyphRuns(line) as! [CTRun] {
            let glyphsCount = CTRunGetGlyphCount(run)
            var buffer = UnsafeMutablePointer<CGPoint>.allocate(capacity: glyphsCount)
            defer {
                buffer.deallocate(capacity: glyphsCount)
            }
            CTRunGetPositions(run, CFRangeMake(0, 0), buffer)
            let runPositions = Array(UnsafeBufferPointer(start: buffer, count: glyphsCount))
            positions += runPositions.map { $0.x }
        }
        return positions
    }
    
    private func getOneLine(attributedString: NSAttributedString) -> CTLine {
        let typesetter = CTTypesetterCreateWithAttributedString(attributedString)
        let line = CTTypesetterCreateLine(typesetter, CFRangeMake(0, 0))
        return line
    }
}
