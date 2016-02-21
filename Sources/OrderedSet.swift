//
//  OrderedSet.swift
//  OrderedSet
//
//  Created by Bradley Hilton on 2/19/16.
//  Copyright © 2016 Brad Hilton. All rights reserved.
//

/// An ordered collection of unique `Element` instances
public struct OrderedSet<Element : Hashable> : Hashable, CollectionType, MutableCollectionType {
    
    internal(set) var array: [Element]
    internal(set) var set: Set<Element>
    
    /// Always zero, which is the index of the first element when non-empty.
    public var startIndex: Int {
        return array.startIndex
    }
    
    /// A "past-the-end" element index; the successor of the last valid
    /// subscript argument.
    public var endIndex: Int {
        return array.endIndex
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
            array = array.enumerate().filter { (index, element) in return index == position || element.hashValue != newValue.hashValue }.map { $0.element }
        }
    }
    
    public var hashValue: Int {
        return set.hashValue
    }
    
}

@warn_unused_result
public func ==<T : Hashable>(lhs: OrderedSet<T>, rhs: OrderedSet<T>) -> Bool {
    return lhs.set == rhs.set
}


