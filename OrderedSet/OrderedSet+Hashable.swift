//
//  OrderedSet+Hashable.swift
//  OrderedSet
//
//  Created by Bradley Hilton on 2/19/16.
//  Copyright © 2016 Brad Hilton. All rights reserved.
//

extension OrderedSet : Hashable {
    
    public var hashValue: Int {
        return set.hashValue
    }
    
}

public func ==<T : Hashable>(lhs: OrderedSet<T>, rhs: OrderedSet<T>) -> Bool {
    return lhs.set == rhs.set
}
