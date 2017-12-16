//
//  Array+IntroSort.swift
//  DataStructures
//
//  Created by Giuseppe Lanza on 09/12/2017.
//  Copyright © 2017 La nuova Era. All rights reserved.
//

import Foundation

public extension Array {
    public mutating func introSort(by areInIncreasingOrder: (Element, Element) -> Bool) {
        Array.introSort(for: &self, by: areInIncreasingOrder)
    }
    
    public func introSorted(by areInIncreasingOrder: (Element, Element) -> Bool) -> [Element] {
        var mutable = self
        Array.introSort(for: &mutable, by: areInIncreasingOrder)
        return mutable
    }
    
    private static func introSort(for array: inout [Element], by areInIncreasingOrder: (Element, Element) -> Bool) {
        guard array.count > 1 else { return }
        let depthLimit = 2 * floor(log2(Double(array.count)))
        
        introSortImplementation(for: &array, range: 0..<array.count, depthLimit: Int(depthLimit), by: areInIncreasingOrder)
    }
    
    private static func introSortImplementation(for array: inout [Element], range: Range<Int>, depthLimit: Int, by areInIncreasingOrder: (Element, Element) -> Bool) {
        if array.distance(from: range.lowerBound, to: range.upperBound) < 20 {
            insertionSort(for: &array, range: range, by: areInIncreasingOrder)
        } else if depthLimit == 0 {
            heapsort(for: &array, range: range, by: areInIncreasingOrder)
        } else {
            let partIdx = partitionIndex(for: &array, subRange: range, by: areInIncreasingOrder)
            introSortImplementation(for: &array, range: range.lowerBound..<partIdx, depthLimit: depthLimit &- 1, by: areInIncreasingOrder)
            introSortImplementation(for: &array, range: partIdx..<range.upperBound, depthLimit: depthLimit &- 1, by: areInIncreasingOrder)
        }
    }
    
    private static func partitionIndex(for elements: inout [Element], subRange range: Range<Int>, by areInIncreasingOrder: (Element, Element) -> Bool) -> Int {
        var lo = range.lowerBound
        var hi = elements.index(before: range.upperBound)
        
        // Sort the first, middle, and last elements, then use the middle value
        // as the pivot for the partition.
        let half = elements.distance(from: lo, to: hi) / 2
        let mid = elements.index(lo, offsetBy: half)
        
        sort3(in: &elements, a: lo, b: mid, c: hi, by: areInIncreasingOrder)
        let pivot = elements[mid]
        
        // Loop invariants:
        // * lo < hi
        // * elements[i] < pivot, for i in range.lowerBound..<lo
        // * pivot <= elements[i] for i in hi..<range.upperBound
        Loop: while true {
            FindLo: do {
                elements.formIndex(after: &lo)
                while lo != hi {
                    if !areInIncreasingOrder(elements[lo], pivot) {
                        break FindLo
                    }
                    elements.formIndex(after: &lo)
                }
                break Loop
            }
            
            FindHi: do {
                elements.formIndex(before: &hi)
                while hi != lo {
                    if areInIncreasingOrder(elements[hi], pivot) { break FindHi }
                    elements.formIndex(before: &hi)
                }
                break Loop
            }
            
            elements.swapAt(lo, hi)
        }
        
        return lo
    }
    
    static func sort3(in array: inout [Element], a: Int, b: Int, c: Int, by areInIncreasingOrder: (Element, Element) -> Bool) {
        switch (areInIncreasingOrder(array[b], array[a]),
                areInIncreasingOrder(array[c], array[b])) {
        case (false, false): break
        case (true, true): array.swapAt(a, c)
        case (true, false):
            array.swapAt(a, b)
            
            if areInIncreasingOrder(array[c], array[b]) {
                array.swapAt(b, c)
            }
        case (false, true):
            array.swapAt(b, c)
            
            if areInIncreasingOrder(array[b], array[a]) {
                array.swapAt(a, b)
            }
        }
    }
}


