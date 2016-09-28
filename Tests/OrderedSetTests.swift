//
//  OrderedSetTests.swift
//  OrderedSetTests
//
//  Created by Bradley Hilton on 2/19/16.
//  Copyright © 2016 Brad Hilton. All rights reserved.
//

import XCTest
@testable import OrderedSet

protocol TableSource {}

class OrderedSetTests: XCTestCase {
    
    func testOrderedSet() {
        var orderedSet: OrderedSet<String> = ["Brad", "Lorraine", "Brad", "Sarah"]
        XCTAssert(orderedSet == ["Brad", "Lorraine", "Sarah"])
        orderedSet.append("Evan")
        XCTAssert(orderedSet == ["Brad", "Lorraine", "Sarah", "Evan"])
        orderedSet.insert("Evan", atIndex: 0)
        XCTAssert(orderedSet == ["Evan", "Brad", "Lorraine", "Sarah"])
        orderedSet[2] = "Brad"
        XCTAssert(orderedSet == ["Evan", "Brad", "Sarah"])
        orderedSet.unionInPlace(["Brad", "Scott", "Ivonne"])
        XCTAssert(orderedSet == ["Evan", "Sarah", "Brad", "Scott", "Ivonne"])
        orderedSet.subtractInPlace(["Brad", "Evan"])
        XCTAssert(orderedSet == ["Sarah", "Scott", "Ivonne"])
        orderedSet.intersectInPlace(["Sarah", "Brad", "Ivonne"])
        XCTAssert(orderedSet == ["Sarah", "Ivonne"])
        orderedSet.appendContentsOf(["Natalie", "Lorraine"])
        orderedSet.exclusiveOrInPlace(["Ivonne", "Brad", "Natalie"])
        XCTAssert(orderedSet == ["Sarah", "Lorraine", "Brad"])
        orderedSet = orderedSet + ["Lorraine", "Natalie"]
        XCTAssert(orderedSet == ["Sarah", "Brad", "Lorraine", "Natalie"])
        orderedSet += ["Sarah", "Sarah", "Scott", "Scott"]
        XCTAssert(orderedSet == ["Brad", "Lorraine", "Natalie", "Sarah", "Scott"])
    }
    
    func testElementEqualTo() {
        let orderedSet: OrderedSet<String> = ["Brad", "Lorraine", "Brad", "Sarah"]
        XCTAssertNotNil(orderedSet.element(equalTo: "Lorraine"))
        XCTAssertNil(orderedSet.element(equalTo: "Aleksei"))
    }
    
    func testOrderPreservance() {
        var orderedSet1: OrderedSet<Int> = [3,2,1]
        let orderedSet2: OrderedSet<Int> = [3,5,1]
        
        orderedSet1.unionInPlace(orderedSet2)
        
        print("orderedSet1.array: ", orderedSet1.array)
        
        XCTAssert(orderedSet1.array == [3,2,1,5])
        
        
    }
}

func ==(lhs: OrderedSet<String>, rhs: Array<String>) -> Bool {
    return lhs.array == rhs && lhs.set == Set(rhs)
}
