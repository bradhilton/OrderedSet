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

    /// Returns `true` if the ordered set contains a member.
    @warn_unused_result
    public func contains(member: Element) -> Bool {
        return set.contains(member)
    }
    
    /// Returns Element equal to input one
    public func element(equalTo element:Element) -> Element? {
        if let indexOfElement = set.indexOf(element) {
            return set[indexOfElement]
        }
        return nil
    }
    
    /// Remove the member from the ordered set and return it if it was present.
    public mutating func remove(member: Element) -> Element? {
        guard let index = array.indexOf(member) else { return nil }
        set.remove(member)
        return array.removeAtIndex(index)
    }

    /// Returns true if the ordered set is a subset of a finite sequence as a `Set`.
    @warn_unused_result
    public func isSubsetOf<S : SequenceType where S.Generator.Element == Element>(sequence: S) -> Bool {
        return set.isSubsetOf(sequence)
    }

    /// Returns true if the ordered set is a subset of a finite sequence as a `Set`
    /// but not equal.
    @warn_unused_result
    public func isStrictSubsetOf<S : SequenceType where S.Generator.Element == Element>(sequence: S) -> Bool {
        return set.isStrictSubsetOf(sequence)
    }

    /// Returns true if the ordered set is a superset of a finite sequence as a `Set`.
    @warn_unused_result
    public func isSupersetOf<S : SequenceType where S.Generator.Element == Element>(sequence: S) -> Bool {
        return set.isSupersetOf(sequence)
    }

    /// Returns true if the ordered set is a superset of a finite sequence as a `Set`
    /// but not equal.
    @warn_unused_result
    public func isStrictSupersetOf<S : SequenceType where S.Generator.Element == Element>(sequence: S) -> Bool {
        return set.isStrictSupersetOf(sequence)
    }

    /// Returns true if no members in the ordered set are in a finite sequence as a `Set`.
    @warn_unused_result
    public func isDisjointWith<S : SequenceType where S.Generator.Element == Element>(sequence: S) -> Bool {
        return set.isDisjointWith(sequence)
    }

    /// Return a new `OrderedSet` with items in both this set and a finite sequence.
    @warn_unused_result
    public func union<S : SequenceType where S.Generator.Element == Element>(sequence: S) -> OrderedSet {
        return copy(self) { (inout set: OrderedSet) in set.unionInPlace(sequence) }
    }
    
    /// Append elements of a finite sequence into this `OrderedSet`.
    public mutating func unionInPlace<S : SequenceType where S.Generator.Element == Element>(sequence: S) {
        appendContentsOf(sequence)
    }

    /// Return a new ordered set with elements in this set that do not occur
    /// in a finite sequence.
    @warn_unused_result
    public func subtract<S : SequenceType where S.Generator.Element == Element>(sequence: S) -> OrderedSet {
        return copy(self) { (inout set: OrderedSet) in set.subtractInPlace(sequence) }
    }

    /// Remove all members in the ordered set that occur in a finite sequence.
    public mutating func subtractInPlace<S : SequenceType where S.Generator.Element == Element>(sequence: S) {
        set.subtractInPlace(sequence)
        array = array.filter { set.contains($0) }
    }
    
    /// Return a new ordered set with elements common to this ordered set and a finite sequence.
    @warn_unused_result
    public func intersect<S : SequenceType where S.Generator.Element == Element>(sequence: S) -> OrderedSet {
        return copy(self) { (inout set: OrderedSet) in set.intersectInPlace(sequence) }
    }
    
    /// Remove any members of this ordered set that aren't also in a finite sequence.
    public mutating func intersectInPlace<S : SequenceType where S.Generator.Element == Element>(sequence: S) {
        set.intersectInPlace(sequence)
        array = array.filter { set.contains($0) }
    }

    /// Return a new ordered set with elements that are either in the ordered set or a finite
    /// sequence but do not occur in both.
    @warn_unused_result
    public func exclusiveOr<S : SequenceType where S.Generator.Element == Element>(sequence: S) -> OrderedSet {
        return copy(self) { (inout set: OrderedSet) in set.exclusiveOrInPlace(sequence) }
    }

    /// For each element of a finite sequence, remove it from the ordered set if it is a
    /// common element, otherwise add it to the ordered set. Repeated elements of the
    /// sequence will be ignored.
    public mutating func exclusiveOrInPlace<S : SequenceType where S.Generator.Element == Element>(sequence: S) {
        set.exclusiveOrInPlace(sequence)
        let (array, _) = collapse(self.array + sequence)
        self.array = array.filter { set.contains($0) }
    }
    
    /// If `!self.isEmpty`, remove the first element and return it, otherwise
    /// return `nil`.
    public mutating func popFirst() -> Element? {
        guard let first = array.first else { return nil }
        set.remove(first)
        return array.removeFirst()
    }
    
}
