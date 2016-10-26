//
//  Stack.swift
//  packd-v2
//
//  Created by Cameron Porter on 10/19/16.
//  Copyright © 2016 Cameron Porter. All rights reserved.
//

import UIKit

struct Stack<Element> {
    var items = [Element]()
    
    var count: Int {
        get {
            return items.count
        }
    }
    
    mutating func push(_ item: Element) {
        items.append(item)
    }
    
    mutating func pop() -> Element? {
        if items.count > 0 {
            return items.removeLast()
        } else {
            return nil
        }
    }
    
    func peek() -> Element? {
        if items.count > 0 {
            return items[items.count - 1]
        } else {
            return nil
        }
    }
}
