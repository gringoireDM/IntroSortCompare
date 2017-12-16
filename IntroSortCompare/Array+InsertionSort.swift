//
//  Array+InsertionSort.swift
//  DataStructures
//
//  Created by Giuseppe Lanza on 10/12/2017.
//  Copyright © 2017 La nuova Era. All rights reserved.
//

import Foundation

public extension Array {
    public mutating func insertionSort(by areInIncreasingOrder: (Element, Element) -> Bool) {
        Array.insertionSort(for: &self, range: 0..<count, by: areInIncreasingOrder)
    }
    
    public func insertionSorted(by areInIncreasingOrder: (Element, Element) -> Bool) -> [Element] {
        var mutating = self
        Array.insertionSort(for: &mutating, range: 0..<mutating.count, by: areInIncreasingOrder)
        return mutating
    }
    
    static func insertionSort(for array: inout [Element], range: Range<Int>, by areInIncreasingOrder: (Element, Element) -> Bool) {
        guard !range.isEmpty else { return }
        
        let start = range.lowerBound
        var sortedEnd = start
        
        array.formIndex(after: &sortedEnd)
        while sortedEnd != range.upperBound {
            let x = array[sortedEnd]
            
            var i = sortedEnd
            repeat {
                let predecessor = array[array.index(before: i)]
                
                guard areInIncreasingOrder(x, predecessor) else { break }
                array[i] = predecessor
                array.formIndex(before: &i)
            } while i != start
            
            if i != sortedEnd {
                array[i] = x
            }
            array.formIndex(after: &sortedEnd)
        }
        
    }
}
