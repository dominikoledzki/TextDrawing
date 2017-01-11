//
//  MyLabel.swift
//  TextDrawing
//
//  Created by Dominik Olędzki on 28/12/2016.
//  Copyright © 2016 Dominik Oledzki. All rights reserved.
//

import UIKit
import CoreGraphics
import CoreText

class MyLabel: UIView {

    var attributedText: NSAttributedString?
    
    override func draw(_ rect: CGRect) {
        guard let ctx = UIGraphicsGetCurrentContext() else { return }
        
        ctx.translateBy(x: 0.0, y: bounds.height)
        ctx.scaleBy(x: 1.0, y: -1.0)
        
        let width = Double(bounds.width)

        let attrString = attributedText as! CFAttributedString
        let redString = attributedText?.mutableCopy() as! NSMutableAttributedString
        redString.addAttribute(NSForegroundColorAttributeName, value: UIColor.red.cgColor, range: NSMakeRange(0, redString.length))

        let typesetter = CTTypesetterCreateWithAttributedString(redString)

        var start: CFIndex = 0
        let length: CFIndex = CFAttributedStringGetLength(redString)
        
        ctx.textPosition = CGPoint(x: 0.0, y: rect.height)
        
        var linesCount = 0
        
        while length - start > 0 {
            let count = CTTypesetterSuggestLineBreak(typesetter, start, width)
            let line = CTTypesetterCreateLine(typesetter, CFRangeMake(start, count))
            start += count
            linesCount += 1
            
            var lineBounds = CTLineGetBoundsWithOptions(line, [])
            let lastLinePosition = ctx.textPosition.y
            
            ctx.textPosition.x = 0.0
            ctx.textPosition.y = lastLinePosition - lineBounds.height - lineBounds.origin.y
            ctx.textPosition.y = floor(ctx.textPosition.y + 0.5)
            CTLineDraw(line, ctx)
            ctx.textPosition.y += lineBounds.origin.y
            
            lineBounds.size.width -= CGFloat(CTLineGetTrailingWhitespaceWidth(line))
            ctx.stroke(lineBounds.offsetBy(dx: 0.0, dy: ctx.textPosition.y), width: 1.0)
        }
        
        // default text layouting
//        var blueString = attributedText?.mutableCopy() as! NSMutableAttributedString
//        blueString.addAttribute(NSForegroundColorAttributeName, value: UIColor.blue.cgColor, range: NSMakeRange(0, blueString.length))
//        ctx.setFillColor(UIColor.blue.cgColor)
//        ctx.setStrokeColor(UIColor.blue.cgColor)
//        let framesetter = CTFramesetterCreateWithAttributedString(blueString)
//        let path = CGPath(rect: bounds, transform: nil)
//        let frame = CTFramesetterCreateFrame(framesetter, CFRangeMake(0, 0), path, nil)
//        CTFrameDraw(frame, ctx)
        
        print(breakPossibilites(in: attributedText!.string))
    }
    
    private func breakPossibilites(in string: String) -> [String.CharacterView.Index] {
        var result: [String.CharacterView.Index] = []
        var index = string.characters.startIndex
        while index != string.characters.endIndex {
            if string.characters[index] == Character(" ") {
                result.append(index)
            }
            index = string.characters.index(after: index)
        }
        
        return result
    }
    
    
}
