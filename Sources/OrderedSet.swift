//
//  OrderedSet.swift
//  OrderedSet
//
//  Created by Bradley Hilton on 2/19/16.
//  Copyright © 2016 Brad Hilton. All rights reserved.
//

/// An ordered collection of unique `Element` instances
public struct OrderedSet<Element : Hashable> : Hashable, Collection, MutableCollection {
    
    internal(set) var array: [Element]
    internal(set) var set: Set<Element>
    
    /// The position of the first element in a nonempty collection.
    ///
    /// If the collection is empty, `startIndex` is equal to `endIndex`.
    public var startIndex: Int {
        return array.startIndex
    }
    
    /// The collection's "past the end" position---that is, the position one
    /// greater than the last valid subscript argument.
    ///
    /// When you need a range that includes the last element of a collection, use
    /// the half-open range operator (`..<`) with `endIndex`. The `..<` operator
    /// creates a range that doesn't include the upper bound, so it's always
    /// safe to use with `endIndex`. For example:
    ///
    ///     let numbers = [10, 20, 30, 40, 50]
    ///     if let index = numbers.index(of: 30) {
    ///         print(numbers[index ..< numbers.endIndex])
    ///     }
    ///     // Prints "[30, 40, 50]"
    ///
    /// If the collection is empty, `endIndex` is equal to `startIndex`.
    public var endIndex: Int {
        return array.endIndex
    }

    /// Returns the position immediately after the given index.
    ///
    /// - Parameter i: A valid index of the collection. `i` must be less than
    ///   `endIndex`.
    /// - Returns: The index value immediately after `i`.
    public func index(after i: Int) -> Int {
        return i + 1
    }
    
    public subscript(position: Int) -> Element {
        get {
            return array[position]
        }
        set {
            let oldValue = array[position]
            set.remove(oldValue)
            array[position] = newValue
            set.insert(newValue)
            array = array.enumerated().filter { (index, element) in return index == position || element.hashValue != newValue.hashValue }.map { $0.element }
        }
    }
    
    public var hashValue: Int {
        return set.hashValue
    }
    
}


public func ==<T : Hashable>(lhs: OrderedSet<T>, rhs: OrderedSet<T>) -> Bool {
    return lhs.set == rhs.set
}


