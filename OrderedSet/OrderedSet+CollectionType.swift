//
//  OrderedSet+CollectionType.swift
//  OrderedSet
//
//  Created by Bradley Hilton on 2/19/16.
//  Copyright © 2016 Brad Hilton. All rights reserved.
//

extension OrderedSet : CollectionType, MutableCollectionType {
    
    public var startIndex: Int {
        return array.startIndex
    }
    
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
    
}
