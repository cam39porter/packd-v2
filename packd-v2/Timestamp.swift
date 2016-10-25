//
//  Timestamp.swift
//  packd-v2
//
//  Created by Cameron Porter on 10/25/16.
//  Copyright © 2016 Cameron Porter. All rights reserved.
//

import UIKit

class Timestamp: NSObject {

    static func getCurrentTimestamp() -> NSNumber {
        let timestamp: NSNumber = NSNumber(integerLiteral: Int(NSDate().timeIntervalSince1970))
        return timestamp
    }
}
