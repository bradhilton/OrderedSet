//
//  OrderedSet+_ArrayType.swift
//  OrderedSet
//
//  Created by Bradley Hilton on 2/20/16.
//  Copyright © 2016 Brad Hilton. All rights reserved.
//

extension OrderedSet : ExpressibleByArrayLiteral, RangeReplaceableCollection {

    /// Replaces the specified subrange of elements with the given collection.
    ///
    /// This method has the effect of removing the specified range of elements
    /// from the collection and inserting the new elements at the same location.
    /// The number of new elements need not match the number of elements being
    /// removed.
    ///
    /// In this example, three elements in the middle of an array of integers are
    /// replaced by the five elements of a `Repeated<Int>` instance.
    ///
    ///      var nums = [10, 20, 30, 40, 50]
    ///      nums.replaceSubrange(1...3, with: repeatElement(1, count: 5))
    ///      print(nums)
    ///      // Prints "[10, 1, 1, 1, 1, 1, 50]"
    ///
    /// If you pass a zero-length range as the `subrange` parameter, this method
    /// inserts the elements of `newElements` at `subrange.startIndex`. Calling
    /// the `insert(contentsOf:at:)` method instead is preferred.
    ///
    /// Likewise, if you pass a zero-length collection as the `newElements`
    /// parameter, this method removes the elements in the given subrange
    /// without replacement. Calling the `removeSubrange(_:)` method instead is
    /// preferred.
    ///
    /// Calling this method may invalidate any existing indices for use with this
    /// collection.
    ///
    /// - Parameters:
    ///   - subrange: The subrange of the collection to replace. The bounds of
    ///     the range must be valid indices of the collection.
    ///   - newElements: The new elements to add to the collection.
    ///
    /// - Complexity: O(*m*), where *m* is the combined length of the collection
    ///   and `newElements`. If the call to `replaceSubrange` simply appends the
    ///   contents of `newElements` to the collection, the complexity is O(*n*),
    ///   where *n* is the length of `newElements`.
    public mutating func replaceSubrange<C : Collection>(_ subRange: Range<Index>, with newElements: C) where C.Iterator.Element == IndexingIterator<OrderedSet>.Element {
        let oldArray = array[subRange]
        let oldSet = Set(oldArray)
        let (newArray, newSet) = collapse(newElements)
        let deletions = oldSet.subtracting(newSet)
        set.subtract(deletions)
        set.formUnion(newSet)
        array.replaceSubrange(subRange, with: newArray)
        array = array.enumerated().filter { (index, element) in return subRange.contains(index) || subRange.lowerBound == index || !newSet.contains(element) }.map { $0.element }
    }

    
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
