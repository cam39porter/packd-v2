//
//  Fonts.swift
//  packd-v2
//
//  Created by Cameron Porter on 10/14/16.
//  Copyright © 2016 Cameron Porter. All rights reserved.
//

import UIKit

struct Fonts {
    static let fontNameBold = "AvenirNextCondensed-Bold"
    static let fontNameLight = "AvenirNextCondensed-UltraLight"
    static let fontName = "AvenirNextCondensed-Regular"
    
    static func boldFont(ofSize size: CGFloat) -> UIFont {
        return UIFont(name: fontNameBold, size: size)!
    }
    
    static func font(ofSize size: CGFloat) -> UIFont {
        return UIFont(name: fontName, size: size)!
    }
    
    static func lightFont(ofSize size: CGFloat) -> UIFont {
        return UIFont(name: fontNameLight, size: size)!
    }
}
