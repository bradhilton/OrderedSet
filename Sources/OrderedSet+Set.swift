//
//  OrderedSet+Set.swift
//  OrderedSet
//
//  Created by Bradley Hilton on 2/20/16.
//  Copyright © 2016 Brad Hilton. All rights reserved.
//

let set = Swift.Set<String>()

extension OrderedSet {
    
    public init(minimumCapacity: Int) {
        self.array = []
        self.set = Set(minimumCapacity: minimumCapacity)
        reserveCapacity(minimumCapacity)
    }

    /// Returns `true` if the ordered set contains a member.
    
    public func contains(_ member: Element) -> Bool {
        return set.contains(member)
    }
    
    /// Remove the member from the ordered set and return it if it was present.
    public mutating func remove(_ member: Element) -> Element? {
        guard let index = array.firstIndex(of: member) else { return nil }
        set.remove(member)
        return array.remove(at: index)
    }

    /// Returns true if the ordered set is a subset of a finite sequence as a `Set`.
    
    public func isSubset<S : Sequence>(of sequence: S) -> Bool where S.Iterator.Element == Element {
        return set.isSubset(of: sequence)
    }

    /// Returns true if the ordered set is a subset of a finite sequence as a `Set`
    /// but not equal.
    
    public func isStrictSubset<S : Sequence>(of sequence: S) -> Bool where S.Iterator.Element == Element {
        return set.isStrictSubset(of: sequence)
    }

    /// Returns true if the ordered set is a superset of a finite sequence as a `Set`.
    
    public func isSuperset<S : Sequence>(of sequence: S) -> Bool where S.Iterator.Element == Element {
        return set.isSuperset(of: sequence)
    }

    /// Returns true if the ordered set is a superset of a finite sequence as a `Set`
    /// but not equal.
    
    public func isStrictSuperset<S : Sequence>(of sequence: S) -> Bool where S.Iterator.Element == Element {
        return set.isStrictSuperset(of: sequence)
    }

    /// Returns true if no members in the ordered set are in a finite sequence as a `Set`.
    
    public func isDisjoint<S : Sequence>(with sequence: S) -> Bool where S.Iterator.Element == Element {
        return set.isDisjoint(with: sequence)
    }

    /// Return a new `OrderedSet` with items in both this set and a finite sequence.
    
    public func union<S : Sequence>(_ sequence: S) -> OrderedSet where S.Iterator.Element == Element {
        return copy(self) { (set: inout OrderedSet) in set.formUnion(sequence) }
    }
    
    /// Append elements of a finite sequence into this `OrderedSet`.
    public mutating func formUnion<S : Sequence>(_ sequence: S) where S.Iterator.Element == Element {
        append(contentsOf: sequence)
    }

    /// Return a new ordered set with elements in this set that do not occur
    /// in a finite sequence.
    
    public func subtracting<S : Sequence>(_ sequence: S) -> OrderedSet where S.Iterator.Element == Element {
        return copy(self) { (set: inout OrderedSet) in set.subtract(sequence) }
    }

    /// Remove all members in the ordered set that occur in a finite sequence.
    public mutating func subtract<S : Sequence>(_ sequence: S) where S.Iterator.Element == Element {
        set.subtract(sequence)
        array = array.filter { set.contains($0) }
    }
    
    /// Return a new ordered set with elements common to this ordered set and a finite sequence.
    
    public func intersection<S : Sequence>(_ sequence: S) -> OrderedSet where S.Iterator.Element == Element {
        return copy(self) { (set: inout OrderedSet) in set.formIntersection(sequence) }
    }
    
    /// Remove any members of this ordered set that aren't also in a finite sequence.
    public mutating func formIntersection<S : Sequence>(_ sequence: S) where S.Iterator.Element == Element {
        set.formIntersection(sequence)
        array = array.filter { set.contains($0) }
    }

    /// Return a new ordered set with elements that are either in the ordered set or a finite
    /// sequence but do not occur in both.
    
    public func symmetricDifference<S : Sequence>(_ sequence: S) -> OrderedSet where S.Iterator.Element == Element {
        return copy(self) { (set: inout OrderedSet) in set.formSymmetricDifference(sequence) }
    }

    /// For each element of a finite sequence, remove it from the ordered set if it is a
    /// common element, otherwise add it to the ordered set. Repeated elements of the
    /// sequence will be ignored.
    public mutating func formSymmetricDifference<S : Sequence>(_ sequence: S) where S.Iterator.Element == Element {
        set.formSymmetricDifference(sequence)
        let (array, _) = collapse(self.array + sequence)
        self.array = array.filter { set.contains($0) }
    }
    
    /// If `!self.isEmpty`, remove the first element and return it, otherwise
    /// return `nil`.
    public mutating func popFirst() -> Element {
        guard let first = array.first else { fatalError() }
        set.remove(first)
        return array.removeFirst()
    }
    
}
