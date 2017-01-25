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
//        return []
    }
}
