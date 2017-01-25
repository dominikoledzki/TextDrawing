//
//  LineBreaker.swift
//  TextDrawing
//
//  Created by Dominik Olędzki on 17/01/2017.
//  Copyright © 2017 Dominik Oledzki.
//

import UIKit
import CoreText

protocol LineBreaker {
    func breakTextToLines(attributedString: NSAttributedString, maxLineWidth: Double) -> [CTLine]
}
