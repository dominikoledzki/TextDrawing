//
//  ViewController.swift
//  TextDrawing
//
//  Created by Dominik Olędzki on 28/12/2016.
//  Copyright © 2016 Dominik Oledzki.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var label: MyLabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let font = UIFont.systemFont(ofSize: 12.0)
//        let font = UIFont(name: "MalayalamSangamMN-Bold", size: 96.0)!
//        let font = UIFont(name: "Optima-BoldItalic", size: 96.0)!
        
        
        let attributedString = NSAttributedString(string: "Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.", attributes: [
            NSFontAttributeName: font
            ])

//        let attributedString = NSAttributedString(string: "Hello, World!")

        label.attributedText = attributedString
    }
}

