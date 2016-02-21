//
//  OrderedSet+ArrayLiteralConvertible.swift
//  OrderedSet
//
//  Created by Bradley Hilton on 2/19/16.
//  Copyright © 2016 Brad Hilton. All rights reserved.
//

extension OrderedSet : ArrayLiteralConvertible {
    
    public init(arrayLiteral elements: Element...) {
        (self.array, self.set) = collapse(elements)
    }
    
}
