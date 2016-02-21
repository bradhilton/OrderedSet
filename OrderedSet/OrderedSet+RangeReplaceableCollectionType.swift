//
//  OrderedSet+RangeReplaceableCollectionType.swift
//  OrderedSet
//
//  Created by Bradley Hilton on 2/19/16.
//  Copyright © 2016 Brad Hilton. All rights reserved.
//

extension OrderedSet : RangeReplaceableCollectionType {
    
    public init() {
        self.array = []
        self.set = []
    }
    
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
    
}
