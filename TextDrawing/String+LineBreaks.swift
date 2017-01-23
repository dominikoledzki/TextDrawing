//
//  String+LineBreaks.swift
//  TextDrawing
//
//  Created by Dominik Olędzki on 06/01/2017.
//  Copyright © 2017 Dominik Oledzki. All rights reserved.
//

import Foundation

extension String {
    func getPotentialLineBreaks() -> [Int] {
        var result = [Int]()
        for (i, pair) in characters.takeElements(by: 2).enumerated() {
            if pair[0] == " " && pair[1] != " " {
                result.append(i + 1)    // break possibility after space, this way you can draw a space at the end of the line (because it's not pritable anyways without changing the string
            }
        }
        return result
    }
}
