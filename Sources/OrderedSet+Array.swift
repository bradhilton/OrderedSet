//
//  OrderedSet+_ArrayType.swift
//  OrderedSet
//
//  Created by Bradley Hilton on 2/20/16.
//  Copyright © 2016 Brad Hilton. All rights reserved.
//

extension OrderedSet {
    
    public init<S : SequenceType where S.Generator.Element == Element>(_ s: S) {
        (self.array, self.set) = collapse(s)
    }

    public var capacity: Int {
        return array.capacity
    }
    
    public mutating func popLast() -> Element? {
        guard let last = array.popLast() else { return nil }
        set.remove(last)
        return last
    }
    
}

public func +=<Element, S : SequenceType where S.Generator.Element == Element>(inout lhs: OrderedSet<Element>, rhs: S) {
    lhs.appendContentsOf(rhs)
}
