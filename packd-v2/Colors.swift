//
//  Colors.swift
//  packd-v2
//
//  Created by Cameron Porter on 10/16/16.
//  Copyright © 2016 Cameron Porter. All rights reserved.
//

import UIKit

struct Colors {
    
    static let background: UIColor = UIColor(netHex: 0xC7C6C4)
    static let highlight: UIColor = UIColor(netHex: 0xFE667B)
    static let contrast: UIColor = UIColor(netHex: 0xF9F7E8)

}


extension UIColor {
    convenience init(red: Int, green: Int, blue: Int) {
        assert(red >= 0 && red <= 255, "Invalid red component")
        assert(green >= 0 && green <= 255, "Invalid green component")
        assert(blue >= 0 && blue <= 255, "Invalid blue component")
        
        self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: 1.0)
    }
    
    convenience init(netHex:Int) {
        self.init(red:(netHex >> 16) & 0xff, green:(netHex >> 8) & 0xff, blue:netHex & 0xff)
    }
}