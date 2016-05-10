//
//  OrderedSet+_ArrayType.swift
//  OrderedSet
//
//  Created by Bradley Hilton on 2/20/16.
//  Copyright © 2016 Brad Hilton. All rights reserved.
//

extension OrderedSet : ArrayLiteralConvertible, RangeReplaceableCollectionType {
    
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
    public init<S : SequenceType where S.Generator.Element == Element>(_ s: S) {
        (self.array, self.set) = collapse(s)
    }
    
    /// Replace the given `subRange` of elements with `newElements`.
    public mutating func replaceRange<C : CollectionType where C.Generator.Element == IndexingGenerator<OrderedSet>.Element>(subRange: Range<Index>, with newElements: C) {
        let oldArray = array[subRange]
        let oldSet = Set(oldArray)
        let (newArray, newSet) = collapse(newElements)
        let deletions = oldSet.subtract(newSet)
        set.subtractInPlace(deletions)
        set.unionInPlace(newSet)
        array.replaceRange(subRange, with: newArray)
        array = array.enumerate().filter { (index, element) in return subRange.contains(index) || subRange.startIndex == index || !newSet.contains(element) }.map { $0.element }
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
public func +=<Element, S : SequenceType where S.Generator.Element == Element>(inout lhs: OrderedSet<Element>, rhs: S) {
    lhs.appendContentsOf(rhs)
}
