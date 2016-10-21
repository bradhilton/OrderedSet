//
//  OrderedSet+_ArrayType.swift
//  OrderedSet
//
//  Created by Bradley Hilton on 2/20/16.
//  Copyright © 2016 Brad Hilton. All rights reserved.
//

extension OrderedSet : ExpressibleByArrayLiteral, RangeReplaceableCollection {
    
    /// Create an instance containing `elements`.
    public init(arrayLiteral elements: Element...) {
        (self.array, self.set) = collapse(elements)
    }
    
    /// Construct an empty OrderedSet.
    public init() {
        self.array = []
        self.set = []
    }
    
    /// Construct from an arbitrary sequence with elements of type `Element`.
    public init<S : Sequence>(_ s: S) where S.Iterator.Element == Element {
        (self.array, self.set) = collapse(s)
    }
    
    /// Replace the given `subRange` of elements with `newElements`.
    public mutating func replaceSubrange<C : Collection>(_ subRange: Range<Int>, with newElements: C) where C.Iterator.Element == IndexingIterator<OrderedSet>.Element {
        let oldArray = array[subRange]
        let oldSet = Set(oldArray)
        let (newArray, newSet) = collapse(newElements)
        let deletions = oldSet.subtracting(newSet)
        set.subtract(deletions)
        set.formUnion(newSet)
        array.replaceSubrange(subRange, with: newArray)
        array = array.enumerated().filter { (index, element) in return subRange.contains(index) || subRange.lowerBound == index || !newSet.contains(element) }.map { $0.element }
    }
    
    

    public var capacity: Int {
        return array.capacity
    }
    
    
    /// If `!self.isEmpty`, remove the last element and return it, otherwise
    /// return `nil`.
    public mutating func popLast() -> Element? {
        guard let last = array.popLast() else { return nil }
        set.remove(last)
        return last
    }
    
}

/// Operator form of `appendContentsOf`.
public func +=<Element, S : Sequence>(lhs: inout OrderedSet<Element>, rhs: S) where S.Iterator.Element == Element {
    lhs.append(contentsOf: rhs)
}
