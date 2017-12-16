//
//  Array+HeapSort.swift
//  DataStructures
//
//  Created by Giuseppe Lanza on 10/12/2017.
//  Copyright © 2017 La nuova Era. All rights reserved.
//

import Foundation


//HaapSort
public extension Array {
    
    public mutating func heapSort(by areInIncreasingOrder: (Element, Element) -> Bool) {
        Array.heapsort(for: &self, range: 0..<count, by: areInIncreasingOrder)
    }
    
    public func heapSorted(by areInIncreasingOrder: (Element, Element) -> Bool) -> [Element] {
        var mutating = self
        Array.heapsort(for: &mutating, range: 0..<mutating.count, by: areInIncreasingOrder)
        return mutating
    }
    
    private static func shiftDown(_ elements: inout [Element], _ index: Int, _ range: Range<Int>, by areInIncreasingOrder: (Element, Element) -> Bool) {
        let countToIndex = elements.distance(from: range.lowerBound, to: index)
        let countFromIndex = elements.distance(from: index, to: range.upperBound)
        
        guard countToIndex + 1 < countFromIndex else { return }
        
        let left = elements.index(index, offsetBy: countToIndex + 1)
        var largest = index
        if areInIncreasingOrder(elements[largest], elements[left]) {
            largest = left
        }
        
        // Check if right child is also within bounds before trying to examine it.
        if countToIndex + 2 < countFromIndex {
            let right = elements.index(after: left)
            if areInIncreasingOrder(elements[largest], elements[right]) {
                largest = right
            }
        }
        // If a child is bigger than the current node, swap them and continue sifting
        // down.
        if largest != index {
            elements.swapAt(index, largest)
            shiftDown(&elements, largest, range, by: areInIncreasingOrder)
        }
        
    }
    
    private static func heapify(_ list: inout [Element], _ range: Range<Int>, by areInIncreasingOrder: (Element, Element) -> Bool) {
        let root = range.lowerBound
        var node = list.index(root, offsetBy: list.distance(from: range.lowerBound, to: range.upperBound)/2)
        
        while node != root {
            list.formIndex(before: &node)
            shiftDown(&list, node, range, by: areInIncreasingOrder)
        }
    }
    
    static func heapsort(for array: inout [Element], range: Range<Int>, by areInIncreasingOrder: (Element, Element) -> Bool) {
        var hi = range.upperBound
        let lo = range.lowerBound
        heapify(&array, range, by: areInIncreasingOrder)
        array.formIndex(before: &hi)
        
        while hi != lo {
            array.swapAt(lo, hi)
            shiftDown(&array, lo, lo..<hi, by: areInIncreasingOrder)
            array.formIndex(before: &hi)
        }
    }
}
