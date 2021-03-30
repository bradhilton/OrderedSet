//
//  Collapse.swift
//  OrderedSet
//
//  Created by Bradley Hilton on 2/19/16.
//  Copyright © 2016 Brad Hilton. All rights reserved.
//

internal func copy<T>(_ orderedSet: OrderedSet<T>, operate: (inout OrderedSet<T>) -> ()) -> OrderedSet<T> {
    var copy = orderedSet
    operate(&copy)
    return copy
}

internal func collapse<Element : Hashable, S : Sequence>(_ s: S) -> ([Element], Set<Element>) where S.Iterator.Element == Element {
    var aSet = Set<Element>()
    return (s.filter { set(&aSet, contains: $0) }, aSet)
}

private func set<Element>(_ set: inout Set<Element>, contains element: Element) -> Bool {
    defer { set.insert(element) }
    return !set.contains(element)
}
