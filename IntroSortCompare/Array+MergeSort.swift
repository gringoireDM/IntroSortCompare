//
//  Array+Sorting.swift
//  DataStructures
//
//  Created by Giuseppe Lanza on 28/10/16.
//  Copyright © 2016 La nuova Era. All rights reserved.
//

import Foundation

public extension Array {
    /**
     Sort the array using the closure as ordering predicate. the used algorithm is merge Sort
     - Parameter areInIncreasingOrder: A predicate that returns `true` if its first argument
     should be ordered before its second argument; otherwise, `false`.
     - complexity: O(n log(n))
     */
    public mutating func mergeSort(by areInIncreasingOrder: (Element, Element) -> Bool) {
        self = mergeSorted(by: areInIncreasingOrder)
    }
    
    /**
     Sort the array using the closure as ordering predicate. the used algorithm is merge Sort
     - Parameter areInIncreasingOrder:  A predicate that returns `true` if its first argument
     should be ordered before its second argument; otherwise, `false`.
     - Returns: A sorted array containing the elements of the caller of the method.
     - MutatingVariant: mergeSort
     - complexity: O(n log(n))
     */
    public func mergeSorted(by areInIncreasingOrder: (Element, Element) -> Bool) -> [Element] {
        return Array.mergeSort(array: self, by: areInIncreasingOrder)
    }
    
    private static func mergeSort(array:[Element], by areInIncreasingOrder: (Element, Element) -> Bool)->[Element] {
        guard array.count > 1 else { return array }
        
        let mid = array.count / 2
        let left = mergeSort(array: Array(array[0..<mid]), by: areInIncreasingOrder)
        let right = mergeSort(array: Array(array[mid..<array.count]), by: areInIncreasingOrder)
        
        return merge(left: left, withRight: right, by: areInIncreasingOrder)
    }
    
    private static func merge(left: [Element], withRight right: [Element], by areInIncreasingOrder: (Element, Element) -> Bool)->[Element] {
        var ordered = [Element]()
        ordered.reserveCapacity(left.count + right.count)
        
        var leftIndex = 0
        var rightIndex = 0
        
        while leftIndex < left.count && rightIndex < right.count {
            let leftElement = left[leftIndex]
            let rightElement = right[rightIndex]
            
            if areInIncreasingOrder(leftElement, rightElement) {
                ordered.append(leftElement)
                leftIndex += 1
            } else {
                ordered.append(rightElement)
                rightIndex += 1
            }
        }
        
        while leftIndex < left.count {
            let leftElement = left[leftIndex]
            ordered.append(leftElement)
            leftIndex += 1
        }
        
        while rightIndex < right.count {
            let rightElement = right[rightIndex]
            ordered.append(rightElement)
            rightIndex += 1
        }
        
        return ordered
    }
}

public extension Array where Element: Comparable {
    /**
     Sort the array using the < func as ordering predicate. the used algorithm is merge Sort
     
     - complexity: O(n log(n))
     */
    public mutating func mergeSort() {
        self = mergeSorted()
    }
    
    /**
     Sort the array using the < func as ordering predicate. the used algorithm is merge Sort

     - Returns: A sorted array containing the elements of the caller of the method.
     - MutatingVariant: mergeSort
     - Complexity: O(n log n)
     */
    public func mergeSorted() -> [Element] {
        return mergeSorted(by: <)
    }
}
