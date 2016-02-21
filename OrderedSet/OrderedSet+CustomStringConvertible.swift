//
//  OrderedSet+CustomStringConvertible.swift
//  OrderedSet
//
//  Created by Bradley Hilton on 2/19/16.
//  Copyright © 2016 Brad Hilton. All rights reserved.
//

extension OrderedSet : CustomStringConvertible, CustomDebugStringConvertible {
    
    public var description: String {
        return array.description
    }
    
    public var debugDescription: String {
        return array.debugDescription
    }
    
}