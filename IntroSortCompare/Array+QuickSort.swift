//
//  Array+QuickSort.swift
//  DataStructures
//
//  Created by Giuseppe Lanza on 09/12/2017.
//  Copyright © 2017 La nuova Era. All rights reserved.
//

import Foundation

public extension Array {
    mutating public func quickSort(by areInIncreasingOrder: (Element, Element)->Bool) {
        Array.quickSort(array: &self, in: 0..<count, by: areInIncreasingOrder)
    }
    
    public func quickSorted(by areInIncreasingOrder: (Element, Element)->Bool) -> [Element] {
        var mutable = self
        Array.quickSort(array: &mutable, in: 0..<mutable.count, by: areInIncreasingOrder)
        return mutable
    }
    
    private static func quickSort(array: inout [Element], in range: Range<Int>, by areInIncreasingOrder: (Element, Element)->Bool) {
        guard !range.isEmpty else { return }
        var lo = range.lowerBound
        var hi = array.index(before: range.upperBound)
        
        guard lo < hi else { return }
        
        let half = array.distance(from: lo, to: hi) / 2
        let mid = array.index(lo, offsetBy: half)
        
        sort3(in: &array, a: lo, b: mid, c: hi, by: areInIncreasingOrder)
        let pivot = array[mid]

        while true {
            array.formIndex(after: &lo)
            guard findLo(in: array, pivot: pivot, from: &lo, to: hi, by: areInIncreasingOrder) else { break }
            array.formIndex(before: &hi)
            guard findHi(in: array, pivot: pivot, from: lo, to: &hi, by: areInIncreasingOrder) else { break }
            array.swapAt(lo, hi)
        }
        
        quickSort(array: &array, in: range.lowerBound..<lo, by: areInIncreasingOrder)
        quickSort(array: &array, in: lo..<range.upperBound, by: areInIncreasingOrder)
    }
    
    private static func findLo(in array: [Element], pivot: Element, from lo: inout Int, to hi: Int, by areInIncreasingOrder: (Element, Element)->Bool) -> Bool {
        while lo != hi {
            if !areInIncreasingOrder(array[lo], pivot) {
                return true
            }
            array.formIndex(after: &lo)
        }
        return false
    }
    
    private static func findHi(in array: [Element], pivot: Element, from lo: Int, to hi: inout Int, by areInIncreasingOrder: (Element, Element)->Bool) -> Bool {
        while hi != lo {
            if areInIncreasingOrder(array[hi], pivot) { return true }
            array.formIndex(before: &hi)
        }
        return false
    }
}
