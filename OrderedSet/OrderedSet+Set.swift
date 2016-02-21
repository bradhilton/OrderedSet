//
//  OrderedSet+Set.swift
//  OrderedSet
//
//  Created by Bradley Hilton on 2/20/16.
//  Copyright © 2016 Brad Hilton. All rights reserved.
//

extension OrderedSet {
    
    public init(minimumCapacity: Int) {
        self.array = []
        self.set = Set(minimumCapacity: minimumCapacity)
        reserveCapacity(minimumCapacity)
    }

    @warn_unused_result
    public func contains(member: Element) -> Bool {
        return set.contains(member)
    }
    
    public mutating func remove(member: Element) -> Element? {
        guard let index = array.indexOf(member) else { return nil }
        set.remove(member)
        return array.removeAtIndex(index)
    }

    @warn_unused_result
    public func isSubsetOf<S : SequenceType where S.Generator.Element == Element>(sequence: S) -> Bool {
        return set.isSubsetOf(sequence)
    }

    @warn_unused_result
    public func isStrictSubsetOf<S : SequenceType where S.Generator.Element == Element>(sequence: S) -> Bool {
        return set.isStrictSubsetOf(sequence)
    }

    @warn_unused_result
    public func isSupersetOf<S : SequenceType where S.Generator.Element == Element>(sequence: S) -> Bool {
        return set.isSupersetOf(sequence)
    }

    @warn_unused_result
    public func isStrictSupersetOf<S : SequenceType where S.Generator.Element == Element>(sequence: S) -> Bool {
        return set.isStrictSupersetOf(sequence)
    }

    @warn_unused_result
    public func isDisjointWith<S : SequenceType where S.Generator.Element == Element>(sequence: S) -> Bool {
        return set.isDisjointWith(sequence)
    }

    @warn_unused_result
    public func union<S : SequenceType where S.Generator.Element == Element>(sequence: S) -> OrderedSet {
        return copy(self) { (inout set: OrderedSet) in set.unionInPlace(sequence) }
    }
    
    public mutating func unionInPlace<S : SequenceType where S.Generator.Element == Element>(sequence: S) {
        appendContentsOf(sequence)
    }

    @warn_unused_result
    public func subtract<S : SequenceType where S.Generator.Element == Element>(sequence: S) -> OrderedSet {
        return copy(self) { (inout set: OrderedSet) in set.subtractInPlace(sequence) }
    }

    public mutating func subtractInPlace<S : SequenceType where S.Generator.Element == Element>(sequence: S) {
        set.subtractInPlace(sequence)
        array = array.filter { set.contains($0) }
    }
    
    @warn_unused_result
    public func intersect<S : SequenceType where S.Generator.Element == Element>(sequence: S) -> OrderedSet {
        return copy(self) { (inout set: OrderedSet) in set.intersectInPlace(sequence) }
    }
    
    public mutating func intersectInPlace<S : SequenceType where S.Generator.Element == Element>(sequence: S) {
        set.intersectInPlace(sequence)
        array = array.filter { set.contains($0) }
    }

    @warn_unused_result
    public func exclusiveOr<S : SequenceType where S.Generator.Element == Element>(sequence: S) -> OrderedSet {
        return copy(self) { (inout set: OrderedSet) in set.exclusiveOrInPlace(sequence) }
    }

    public mutating func exclusiveOrInPlace<S : SequenceType where S.Generator.Element == Element>(sequence: S) {
        set.exclusiveOrInPlace(sequence)
        let (array, _) = collapse(self.array + sequence)
        self.array = array.filter { set.contains($0) }
    }
    
    public mutating func popFirst() -> Element? {
        guard let first = array.first else { return nil }
        set.remove(first)
        return array.removeFirst()
    }
    
}
